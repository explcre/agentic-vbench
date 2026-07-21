#!/usr/bin/env python3
"""Deterministic generator for the "sort-visualization swap-ledger" understanding task.

It does three things from a single seed, so the video and the answer key can never
drift apart:

  1. Runs a *randomized* quicksort (random pivot each partition) on a random
     permutation of 1..N, recording every position swap in order. The random pivots
     are the hidden entropy: the swap sequence is NOT a function of the visible
     initial arrangement, so an agent cannot reproduce it by reading one frame and
     simulating a textbook sort -- it has to watch the whole video.
  2. Writes the ground-truth ledger (the ordered list of swapped height-rank pairs)
     plus a rich audit log (positions + frame index of every swap).
  3. Renders a silent bar-chart animation to mp4: uniform-colour bars whose only
     distinguishing feature is height (= rank), one swap animated at a time, no text,
     no axes, no algorithm name.

Everything is seeded, so `--seed S --n N ...` reproduces byte-for-identical logs and
an identical video (modulo the encoder).

Usage
-----
  module load ffmpeg/4.2.2
  python3 gen_sortviz.py --seed 7 --n 50 --fps 20 \
      --out-video out.mp4 --out-gt gt.json --out-audit audit.json \
      --ffmpeg $(which ffmpeg)
"""
import argparse
import json
import random
import struct
import subprocess
import sys
from pathlib import Path

import numpy as np


def randomized_quicksort_swaps(arr, rng):
    """Sort `arr` (list of distinct ints) in place with random-pivot Lomuto quicksort.

    Returns the chronological list of swaps. Each swap is a dict with the two 0-based
    positions and the two height-ranks (values) that exchanged places. No-op swaps
    (i == j) are not recorded because they produce no visible motion.
    """
    swaps = []

    def partition(lo, hi):
        p = rng.randint(lo, hi)               # random pivot index -> hidden entropy
        if p != hi:
            arr[p], arr[hi] = arr[hi], arr[p]
            swaps.append({"pos": [p, hi], "ranks": sorted([arr[p], arr[hi]])})
        pivot = arr[hi]
        i = lo
        for j in range(lo, hi):
            if arr[j] < pivot:
                if i != j:
                    arr[i], arr[j] = arr[j], arr[i]
                    swaps.append({"pos": [i, j], "ranks": sorted([arr[i], arr[j]])})
                i += 1
        if i != hi:
            arr[i], arr[hi] = arr[hi], arr[i]
            swaps.append({"pos": [i, hi], "ranks": sorted([arr[i], arr[hi]])})
        return i

    def qsort(lo, hi):
        if lo < hi:
            m = partition(lo, hi)
            qsort(lo, m - 1)
            qsort(m + 1, hi)

    qsort(0, len(arr) - 1)
    return swaps


def render(states_iter, width, height, n, ffmpeg, out_video, fps):
    """Pipe RGB frames to ffmpeg. `states_iter` yields (array_state, moving) tuples
    where `moving` maps position -> fractional x offset for the swap animation."""
    proc = subprocess.Popen(
        [ffmpeg, "-y", "-f", "rawvideo", "-pix_fmt", "rgb24",
         "-s", f"{width}x{height}", "-r", str(fps), "-i", "-",
         "-an", "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "20",
         "-loglevel", "error", str(out_video)],
        stdin=subprocess.PIPE,
    )
    bg = np.array([255, 255, 255], dtype=np.uint8)
    bar = np.array([70, 110, 170], dtype=np.uint8)      # uniform steel blue
    margin = int(height * 0.08)
    usable_h = height - 2 * margin
    slot = width / n
    bw = slot * 0.7
    nframes = 0
    for state, moving in states_iter:
        frame = np.empty((height, width, 3), dtype=np.uint8)
        frame[:, :] = bg
        for pos, val in enumerate(state):
            xoff = moving.get(pos, 0.0)
            cx = (pos + xoff + 0.5) * slot
            x0 = int(cx - bw / 2)
            x1 = int(cx + bw / 2)
            bh = int(usable_h * val / n)
            y1 = height - margin
            y0 = y1 - bh
            x0 = max(0, min(width - 1, x0))
            x1 = max(x0 + 1, min(width, x1))
            frame[y0:y1, x0:x1] = bar
        proc.stdin.write(frame.tobytes())
        nframes += 1
    proc.stdin.close()
    proc.wait()
    if proc.returncode != 0:
        raise RuntimeError(f"ffmpeg exited {proc.returncode}")
    return nframes


def frames_for_run(init_state, swaps, swap_frames, hold_frames, settle_frames):
    """Yield per-frame (state, moving-offsets). Animates each swap as a linear slide
    of the two bars past each other, then a hold with the array in its new order."""
    state = list(init_state)
    # opening hold on the initial arrangement
    for _ in range(settle_frames):
        yield list(state), {}
    for sw in swaps:
        a, b = sw["pos"]
        va, vb = state[a], state[b]
        for f in range(swap_frames):
            t = (f + 1) / swap_frames
            # a moves toward b, b moves toward a (offsets in slot units)
            yield list(state), {a: (b - a) * t, b: (a - b) * t}
        state[a], state[b] = vb, va          # commit the swap
        for _ in range(hold_frames):
            yield list(state), {}
    for _ in range(settle_frames):
        yield list(state), {}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--n", type=int, default=50)
    ap.add_argument("--fps", type=int, default=20)
    ap.add_argument("--swap-frames", type=int, default=16)
    ap.add_argument("--hold-frames", type=int, default=10)
    ap.add_argument("--settle-frames", type=int, default=40)
    ap.add_argument("--width", type=int, default=1280)
    ap.add_argument("--height", type=int, default=720)
    ap.add_argument("--ffmpeg", default="ffmpeg")
    ap.add_argument("--out-video", type=Path)
    ap.add_argument("--out-gt", type=Path, required=True,
                    help="verifier-side ground_truth.json (read by judge.py)")
    ap.add_argument("--out-audit", type=Path)
    ap.add_argument("--out-solve-sh", type=Path,
                    help="write the oracle solve.sh with the ledger embedded")
    ap.add_argument("--no-render", action="store_true", help="logs only, skip video")
    args = ap.parse_args()

    rng = random.Random(args.seed)
    init = list(range(1, args.n + 1))
    rng.shuffle(init)                          # visible initial arrangement
    work = list(init)
    swaps = randomized_quicksort_swaps(work, rng)
    assert work == sorted(work), "quicksort did not sort"

    # Timestamp of swap k: middle of its slide animation, in video seconds.
    sf, hf, st = args.swap_frames, args.hold_frames, args.settle_frames
    for k, sw in enumerate(swaps):
        frame_mid = st + k * (sf + hf) + sf / 2.0
        sw["t_sec"] = round(frame_mid / args.fps, 2)

    # Ground truth: each swap = the pair of height-ranks that traded places, with the
    # approximate time it happens. (bars 1=shortest .. n=tallest.)
    gt = {"n": args.n,
          "swaps": [{"t_sec": sw["t_sec"], "bars": sw["ranks"]} for sw in swaps]}
    args.out_gt.write_text(json.dumps(gt, indent=2))

    dur_frames = (args.settle_frames * 2
                  + len(swaps) * (args.swap_frames + args.hold_frames))
    dur_s = dur_frames / args.fps
    if args.out_audit:
        args.out_audit.write_text(json.dumps({
            "seed": args.seed, "n": args.n, "init": init,
            "num_swaps": len(swaps), "duration_s": round(dur_s, 1),
            "fps": args.fps, "swaps_detailed": swaps,
        }, indent=2))

    if args.out_solve_sh:
        oracle = {"swaps": [{"t": sw["t_sec"], "bars": sw["ranks"]} for sw in swaps]}
        payload = json.dumps(oracle, indent=2)
        script = (
            "#!/bin/bash\n"
            "# Oracle: write the verified swap ledger as solution.json.\n"
            "# Auto-generated by tools/gen_sortviz.py from the same seed as the video,\n"
            "# so it is the answer key, not an echo of the input. The agent never sees it.\n"
            "set -euo pipefail\n"
            "mkdir -p /workspace/output\n"
            "cat > /workspace/output/solution.json <<'ORACLE_JSON'\n"
            f"{payload}\n"
            "ORACLE_JSON\n"
            f'echo "oracle: wrote /workspace/output/solution.json ({len(swaps)} swaps)"\n'
        )
        args.out_solve_sh.write_text(script)

    print(f"seed={args.seed} n={args.n} swaps={len(swaps)} "
          f"frames={dur_frames} duration={dur_s/60:.1f} min")

    if not args.no_render:
        if not args.out_video:
            sys.exit("--out-video required unless --no-render")
        frames = frames_for_run(init, swaps, args.swap_frames,
                                args.hold_frames, args.settle_frames)
        n = render(frames, args.width, args.height, args.n,
                   args.ffmpeg, args.out_video, args.fps)
        print(f"rendered {n} frames -> {args.out_video}")


if __name__ == "__main__":
    main()

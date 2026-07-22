#!/usr/bin/env python3
"""Grade a music-transcription-ledger reconstruction. Pure stdlib, deterministic.

The video is a ~10-minute scrolling piano-roll of a multi-voice piece, with its audio.
Every note is both heard (a clear-pitched tone) and seen (a bar falling to the now-line).
Pitch is NOT labelled on screen and the vertical axis is compressed, so exact pitch must
come from the AUDIO; onset timing and polyphony (how many notes start together) are clear
in the VIDEO. The agent reconstructs the note-event ledger: for each note, its pitch and
onset time.

A predicted note is a true positive when an unused ground-truth note has the same pitch
and an onset within TOL seconds. Score = F1 over notes (misses and inventions both hurt).
reward = F1.

Pitch may be given as a MIDI number (e.g. 60) or a scientific pitch name (e.g. C4, F#5,
Bb3); both are normalised to a MIDI integer. Ground truth is baked verifier-side at
/tests/ground_truth.json.
"""
import argparse
import json
import re
from pathlib import Path

TOL = 0.4  # seconds of onset tolerance

GT_PATH = Path(__file__).with_name("ground_truth.json")
_STEP = {"c": 0, "d": 2, "e": 4, "f": 5, "g": 7, "a": 9, "b": 11}


def to_midi(v):
    """Accept a MIDI int, a numeric string, or a scientific pitch name -> MIDI int or None."""
    if isinstance(v, bool):
        return None
    if isinstance(v, (int, float)):
        return int(v)
    if not isinstance(v, str):
        return None
    s = v.strip()
    if re.fullmatch(r"-?\d+", s):
        return int(s)
    m = re.fullmatch(r"([A-Ga-g])([#b]?)(-?\d+)", s.strip())
    if not m:
        return None
    step, acc, octv = m.group(1).lower(), m.group(2), int(m.group(3))
    semi = _STEP[step] + (1 if acc == "#" else -1 if acc == "b" else 0)
    return (octv + 1) * 12 + semi  # C4 = 60


def to_time(v):
    if v is None:
        return None
    s = str(v).strip()
    try:
        if ":" in s:
            parts = [float(x) for x in s.split(":")]
            t = 0.0
            for x in parts:
                t = t * 60 + x
            return t
        return float(s)
    except (ValueError, TypeError):
        return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    args = ap.parse_args()

    gt = json.loads(GT_PATH.read_text())["notes"]
    reason = "ok"
    preds = []
    try:
        sol = json.loads(args.solution.read_text())
        preds = sol.get("notes", [])
        if not isinstance(preds, list):
            raise ValueError("notes is not a list")
    except Exception as exc:  # noqa: BLE001
        reason, preds = f"unreadable solution.json: {exc}", []

    # bucket GT by pitch for efficient matching
    from collections import defaultdict
    gt_by_pitch = defaultdict(list)
    for i, g in enumerate(gt):
        gt_by_pitch[int(g["pitch"])].append([float(g["t"]), False])  # [time, used]

    tp = 0
    for pr in preds:
        if not isinstance(pr, dict):
            continue
        p = to_midi(pr.get("pitch"))
        t = to_time(pr.get("t"))
        if p is None or t is None:
            continue
        best, best_dt = -1, None
        cand = gt_by_pitch.get(p, [])
        for j, (gt_t, used) in enumerate(cand):
            if used:
                continue
            dt = abs(t - gt_t)
            if dt <= TOL and (best_dt is None or dt < best_dt):
                best, best_dt = j, dt
        if best >= 0:
            cand[best][1] = True
            tp += 1

    n_pred, n_gt = len(preds), len(gt)
    precision = tp / n_pred if n_pred else 0.0
    recall = tp / n_gt if n_gt else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if (precision + recall) else 0.0

    details = {
        "reason": reason, "n_ground_truth": n_gt, "n_predicted": n_pred,
        "true_positives": tp, "precision": round(precision, 4),
        "recall": round(recall, 4), "f1": round(f1, 4), "onset_tolerance_s": TOL,
    }
    args.reward_json.parent.mkdir(parents=True, exist_ok=True)
    args.reward_json.write_text(json.dumps({"reward": round(f1, 4), "details": details}, indent=2))
    args.reward_txt.write_text(f"{round(f1, 4)}\n")


if __name__ == "__main__":
    main()

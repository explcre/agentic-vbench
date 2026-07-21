#!/usr/bin/env python3
"""Grade a sort-visualization swap-ledger reconstruction. Pure stdlib, deterministic.

The video shows N uniform-colour bars of distinct heights being sorted; the only
events are position swaps, animated one at a time. The agent must list every swap as
the unordered pair of height-ranks that traded places (1 = shortest bar, N = tallest)
together with the approximate time it happened.

A predicted swap is a true positive when an unused ground-truth swap has the SAME
unordered rank-pair and a time within TOL seconds. We score by F1, so both missed
swaps and invented swaps hurt. reward = F1.

Why this metric: the swap sequence comes from a random-pivot quicksort, so it is not
a function of the visible initial arrangement -- an agent cannot reproduce it from a
single frame by simulating a textbook sort; it must actually watch the whole video.
Hundreds of near-identical swaps over many minutes make dense, accurate tracking the
only path to a high score. Oracle (exact ledger) -> 1.0; empty or guessed -> ~0.

Ground truth is baked verifier-side at /tests/ground_truth.json.
"""
import argparse
import json
from pathlib import Path

TOL = 3.0  # seconds of timing tolerance (a swap animation is ~1s; reads should be close)

GT_PATH = Path(__file__).with_name("ground_truth.json")


def load_gt():
    d = json.loads(GT_PATH.read_text())
    return d["n"], d["swaps"]


def to_time(v):
    """Accept seconds (number/'12.5') or 'mm:ss'. Return float seconds or None."""
    if v is None:
        return None
    s = str(v).strip()
    try:
        if ":" in s:
            parts = s.split(":")
            parts = [float(p) for p in parts]
            sec = 0.0
            for p in parts:
                sec = sec * 60 + p
            return sec
        return float(s)
    except (ValueError, TypeError):
        return None


def to_pair(bars):
    """Return canonical (lo, hi) int pair or None if malformed."""
    if not isinstance(bars, (list, tuple)) or len(bars) != 2:
        return None
    try:
        a, b = int(bars[0]), int(bars[1])
    except (ValueError, TypeError):
        return None
    if a == b:
        return None
    return (min(a, b), max(a, b))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    args = ap.parse_args()

    n, gt = load_gt()
    reason = "ok"
    preds = []
    try:
        sol = json.loads(args.solution.read_text())
        preds = sol.get("swaps", [])
        if not isinstance(preds, list):
            raise ValueError("swaps is not a list")
    except Exception as exc:  # noqa: BLE001 - malformed output scores 0
        reason, preds = f"unreadable solution.json: {exc}", []

    used = [False] * len(gt)
    tp = 0
    for pr in preds:
        if not isinstance(pr, dict):
            continue
        pair = to_pair(pr.get("bars"))
        t = to_time(pr.get("t") if "t" in pr else pr.get("t_sec"))
        if pair is None or t is None:
            continue
        best = -1
        best_dt = None
        for i, g in enumerate(gt):
            if used[i]:
                continue
            if to_pair(g["bars"]) != pair:
                continue
            dt = abs(t - float(g["t_sec"]))
            if dt <= TOL and (best_dt is None or dt < best_dt):
                best, best_dt = i, dt
        if best >= 0:
            used[best] = True
            tp += 1

    n_pred, n_gt = len(preds), len(gt)
    precision = tp / n_pred if n_pred else 0.0
    recall = tp / n_gt if n_gt else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if (precision + recall) else 0.0

    details = {
        "reason": reason,
        "n_bars": n,
        "n_ground_truth": n_gt,
        "n_predicted": n_pred,
        "true_positives": tp,
        "precision": round(precision, 4),
        "recall": round(recall, 4),
        "f1": round(f1, 4),
        "time_tolerance_s": TOL,
    }
    args.reward_json.parent.mkdir(parents=True, exist_ok=True)
    args.reward_json.write_text(json.dumps({"reward": round(f1, 4), "details": details}, indent=2))
    args.reward_txt.write_text(f"{round(f1, 4)}\n")


if __name__ == "__main__":
    main()

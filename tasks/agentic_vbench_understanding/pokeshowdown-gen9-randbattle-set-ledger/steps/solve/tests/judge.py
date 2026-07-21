#!/usr/bin/env python3
"""Grade a Pokemon Showdown battle-set structural-ledger reconstruction.

Deterministic, pure stdlib. The video is a set of muted Gen9 random battles played
back to back. The agent reconstructs, across all games, every switch-in (a Pokemon
becoming active: lead, switch, or forced drag) and every faint, tagged with the game
number, the turn, the side, and the species.

A predicted event is a true positive when an unused ground-truth event has the same
game, side, event type, normalized species, and a turn within TOL. Score = F1, so
missed and invented events both hurt. Move names are intentionally not scored: they
are unreadable from the muted scene (they live only in the hidden text log).

Ground truth is baked verifier-side at /tests/ground_truth.json.
"""
import argparse
import json
import re
from pathlib import Path

TOL = 1  # turns of tolerance
GT_PATH = Path(__file__).with_name("ground_truth.json")


def norm(s):
    return re.sub(r"[^a-z0-9]", "", str(s).lower())


def key_of(e):
    return (e.get("game"), e.get("side"), norm(e.get("event")), norm(e.get("species")))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    args = ap.parse_args()

    gt = json.loads(GT_PATH.read_text())["events"]
    reason = "ok"
    preds = []
    try:
        sol = json.loads(args.solution.read_text())
        preds = sol.get("events", [])
        if not isinstance(preds, list):
            raise ValueError("events is not a list")
    except Exception as exc:  # noqa: BLE001
        reason, preds = f"unreadable solution.json: {exc}", []

    used = [False] * len(gt)
    tp = 0
    for pr in preds:
        if not isinstance(pr, dict):
            continue
        try:
            pk = key_of(pr)
            pt = int(pr.get("turn"))
        except (ValueError, TypeError):
            continue
        best, best_dt = -1, None
        for i, g in enumerate(gt):
            if used[i] or key_of(g) != pk:
                continue
            dt = abs(pt - int(g["turn"]))
            if dt <= TOL and (best_dt is None or dt < best_dt):
                best, best_dt = i, dt
        if best >= 0:
            used[best] = True
            tp += 1

    n_pred, n_gt = len(preds), len(gt)
    precision = tp / n_pred if n_pred else 0.0
    recall = tp / n_gt if n_gt else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if (precision + recall) else 0.0
    details = {"reason": reason, "n_ground_truth": n_gt, "n_predicted": n_pred,
               "true_positives": tp, "precision": round(precision, 4),
               "recall": round(recall, 4), "f1": round(f1, 4), "turn_tolerance": TOL}
    args.reward_json.parent.mkdir(parents=True, exist_ok=True)
    args.reward_json.write_text(json.dumps({"reward": round(f1, 4), "details": details}, indent=2))
    args.reward_txt.write_text(f"{round(f1, 4)}\n")


if __name__ == "__main__":
    main()

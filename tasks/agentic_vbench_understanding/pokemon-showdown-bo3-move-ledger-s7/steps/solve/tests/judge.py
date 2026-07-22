#!/usr/bin/env python3
"""Grade a Pokemon Showdown best-of-3 move-ledger reconstruction. Pure stdlib.

The video shows a 3-game random-battle series with the move-name text bar hidden, so
the agent must infer each move from its animation and HP change, choosing among the
moveset revealed in the prompt. It lists, for every turn of every game, the move each
side used.

A predicted move is a true positive when an unused ground-truth move has the same
game, the same side, the same move name (normalised), and a turn within TURN_TOL.
Score = F1, so both misses and inventions hurt. reward = F1.

Why this is hard and shortcut-free: the move-name text is not on screen (only the
animation and HP bars are), the series is 388 moves over many minutes, and the play
order is random so it cannot be derived from the teams alone. Oracle -> 1.0; empty or
guessed -> ~0.

Ground truth is baked verifier-side at /tests/ground_truth.json.
"""
import argparse
import json
import re
from pathlib import Path

TURN_TOL = 1  # allow a turn off-by-one (agents may miscount turn boundaries slightly)

GT_PATH = Path(__file__).with_name("ground_truth.json")


def norm(s):
    return re.sub(r"[^a-z0-9]", "", str(s).lower())


def side_norm(s):
    s = norm(s)
    return {"red": "red", "p1": "red", "blue": "blue", "p2": "blue"}.get(s, s)


def load_gt():
    d = json.loads(GT_PATH.read_text())
    return d["moves"]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    args = ap.parse_args()

    gt = load_gt()
    reason = "ok"
    preds = []
    try:
        sol = json.loads(args.solution.read_text())
        preds = sol.get("moves", [])
        if not isinstance(preds, list):
            raise ValueError("moves is not a list")
    except Exception as exc:  # noqa: BLE001
        reason, preds = f"unreadable solution.json: {exc}", []

    used = [False] * len(gt)
    tp = 0
    for pr in preds:
        if not isinstance(pr, dict):
            continue
        try:
            pg = int(pr.get("game"))
            pt = int(pr.get("turn"))
        except (TypeError, ValueError):
            continue
        ps = side_norm(pr.get("side"))
        pm = norm(pr.get("move"))
        if not pm:
            continue
        best, best_dt = -1, None
        for i, g in enumerate(gt):
            if used[i] or g["game"] != pg:
                continue
            if side_norm(g["side"]) != ps or norm(g["move"]) != pm:
                continue
            dt = abs(pt - int(g["turn"]))
            if dt <= TURN_TOL and (best_dt is None or dt < best_dt):
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
        "n_ground_truth": n_gt,
        "n_predicted": n_pred,
        "true_positives": tp,
        "precision": round(precision, 4),
        "recall": round(recall, 4),
        "f1": round(f1, 4),
        "turn_tolerance": TURN_TOL,
    }
    args.reward_json.parent.mkdir(parents=True, exist_ok=True)
    args.reward_json.write_text(json.dumps({"reward": round(f1, 4), "details": details}, indent=2))
    args.reward_txt.write_text(f"{round(f1, 4)}\n")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Grade a Minecraft build/mine session-ledger reconstruction. Pure stdlib, deterministic.

The video shows a bot laying a flat mosaic of distinct block types on the ground and
then mining some back to grass, one event at a time, over ~12 minutes (rendered with
prismarine-viewer, fixed camera). The agent reconstructs the ORDERED ledger of block
events: the chronological sequence of (action, block-type), where action is place or
break and block-type is one of a closed 11-type vocabulary.

Scoring is order-aware so that timing jitter in the render is irrelevant: we align the
predicted token sequence to the ground-truth token sequence by longest common
subsequence (LCS) and report F1 = 2*LCS / (len_pred + len_gt). Getting the right events
in the right order scores high; misses, invented events, wrong block types, and gross
reorderings all lower it. reward = LCS-F1.

Why order (not timestamps): the software-GL render has a variable frame rate, so the
video timeline is not a linear function of wall-clock; the reliable, machine-perfect
ground truth is the *order* of the bot's commands. The task stays hard and shortcut
free: ~80 events over 12 minutes, block identity read from the rendered texture, no
HUD/chat — a single frame or one modality cannot recover the ordered sequence.

Ground truth (ordered tokens) is baked verifier-side at /tests/ground_truth.json.
"""
import argparse
import json
import re
from pathlib import Path

GT_PATH = Path(__file__).with_name("ground_truth.json")


def norm(s):
    return re.sub(r"[^a-z0-9]", "", str(s).lower())


def action_norm(a):
    a = norm(a)
    if a in ("placed", "add", "added", "put", "set"):
        return "place"
    if a in ("broke", "broken", "mine", "mined", "remove", "removed", "destroy", "destroyed"):
        return "break"
    return a


def token(ev):
    return (action_norm(ev.get("action")), norm(ev.get("block")))


def lcs_len(a, b):
    """Length of the longest common subsequence of two token lists (O(len_a*len_b))."""
    n, m = len(a), len(b)
    if n == 0 or m == 0:
        return 0
    prev = [0] * (m + 1)
    for i in range(1, n + 1):
        cur = [0] * (m + 1)
        ai = a[i - 1]
        for j in range(1, m + 1):
            if ai == b[j - 1]:
                cur[j] = prev[j - 1] + 1
            else:
                cur[j] = prev[j] if prev[j] >= cur[j - 1] else cur[j - 1]
        prev = cur
    return prev[m]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    args = ap.parse_args()

    gt = [token(e) for e in json.loads(GT_PATH.read_text())["events"]]
    reason = "ok"
    preds = []
    try:
        sol = json.loads(args.solution.read_text())
        raw = sol.get("events", [])
        if not isinstance(raw, list):
            raise ValueError("events is not a list")
        preds = [token(e) for e in raw if isinstance(e, dict)]
    except Exception as exc:  # noqa: BLE001
        reason, preds = f"unreadable solution.json: {exc}", []

    lcs = lcs_len(preds, gt)
    n_pred, n_gt = len(preds), len(gt)
    f1 = (2 * lcs / (n_pred + n_gt)) if (n_pred + n_gt) else 0.0

    details = {
        "reason": reason, "n_ground_truth": n_gt, "n_predicted": n_pred,
        "lcs": lcs, "f1": round(f1, 4),
        "note": "order-aware LCS F1 over (action, block) tokens",
    }
    args.reward_json.parent.mkdir(parents=True, exist_ok=True)
    args.reward_json.write_text(json.dumps({"reward": round(f1, 4), "details": details}, indent=2))
    args.reward_txt.write_text(f"{round(f1, 4)}\n")


if __name__ == "__main__":
    main()

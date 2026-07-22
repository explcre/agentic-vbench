#!/usr/bin/env python3
"""Grade a Minecraft first-person gameplay-ledger reconstruction. Pure stdlib, deterministic.

The video is a ~10-minute FIRST-PERSON recording of a player exploring a generated
Minecraft world: walking, looking around, mining blocks (the camera turns to each block
as it breaks), and fighting a mob. The agent reconstructs the ORDERED ledger of the
player's deliberate actions: the chronological sequence of (action, target), where
action is `mine` (a block is broken; target = block type) or `kill` (a mob is defeated;
target = mob type).

Scoring is order-aware (LCS) so the moving first-person camera and the render frame-rate
are irrelevant: F1 = 2*LCS / (len_pred + len_gt) over the (action, target) token
sequence. Misses, invented actions, wrong block/mob types, and reorderings all lower it.
reward = LCS-F1.

Why order (not timestamps): a first-person session has a moving camera and the software
render is variable-FPS, so the reliable machine-exact ground truth is the ORDER of the
player's actions (mineflayer events). The task stays hard and shortcut free: ~90 actions
over ~10 minutes in first person, block/mob identity read from the rendered textures, no
HUD — a single frame or a still cannot recover the ordered action sequence.

Ground truth (ordered tokens) is baked verifier-side at /tests/ground_truth.json.
"""
import argparse, json, re
from pathlib import Path
GT_PATH = Path(__file__).with_name("ground_truth.json")

def norm(s): return re.sub(r"[^a-z0-9]", "", str(s).lower())

def act_norm(a):
    a = norm(a)
    if a in ("mine","mined","break","broke","dig","dug"): return "mine"
    if a in ("kill","killed","mobkill","defeat","defeated","slay","slew"): return "kill"
    return a

def token(ev): return (act_norm(ev.get("action") or ev.get("event")), norm(ev.get("target") or ev.get("block")))

def lcs_len(a, b):
    n, m = len(a), len(b)
    if n == 0 or m == 0: return 0
    prev = [0]*(m+1)
    for i in range(1, n+1):
        cur = [0]*(m+1); ai = a[i-1]
        for j in range(1, m+1):
            cur[j] = prev[j-1]+1 if ai == b[j-1] else (prev[j] if prev[j] >= cur[j-1] else cur[j-1])
        prev = cur
    return prev[m]

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    a = ap.parse_args()
    gt = [token(e) for e in json.loads(GT_PATH.read_text())["events"]]
    reason = "ok"; preds = []
    try:
        raw = json.loads(a.solution.read_text()).get("events", [])
        if not isinstance(raw, list): raise ValueError("events not a list")
        preds = [token(e) for e in raw if isinstance(e, dict)]
    except Exception as exc:  # noqa: BLE001
        reason = f"unreadable solution.json: {exc}"
    lcs = lcs_len(preds, gt); np_, ng = len(preds), len(gt)
    f1 = (2*lcs/(np_+ng)) if (np_+ng) else 0.0
    det = {"reason": reason, "n_ground_truth": ng, "n_predicted": np_, "lcs": lcs,
           "f1": round(f1,4), "note": "order-aware LCS F1 over (action,target) tokens"}
    a.reward_json.parent.mkdir(parents=True, exist_ok=True)
    a.reward_json.write_text(json.dumps({"reward": round(f1,4), "details": det}, indent=2))
    a.reward_txt.write_text(f"{round(f1,4)}\n")

if __name__ == "__main__": main()

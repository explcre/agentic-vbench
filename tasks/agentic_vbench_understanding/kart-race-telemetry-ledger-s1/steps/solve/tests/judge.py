#!/usr/bin/env python3
"""Grade a SuperTuxKart race-telemetry reconstruction. Pure stdlib, deterministic.

The video is a suite of AI-driven races on different tracks. For each race the agent reports,
per kart, where it finished and how many powerup boxes it collected.

Both components are scored as **rank agreement**, not exact match:

    reward = 0.70 * tau(finish order) + 0.30 * tau(items-collected order)

where tau is the normalised Kendall correlation over kart pairs,
`(concordant - discordant) / n_pairs`, clamped at 0.

Why rank agreement rather than per-field accuracy. An earlier version scored exact positions
plus counts with a tolerance, and measured floors far above the family's anti-shortcut bar: a
blind guess (random order, modal counts) scored 0.33 and reading only the starting grid from
a single frame scored 0.43. Both exploited free credit — a random permutation still lands
1-in-6 positions exactly, and sparse counts like bananas and rescues are almost always zero,
so guessing zero is nearly right. Under rank agreement, guessing at random earns 0 in
expectation (concordant and discordant pairs cancel), and a wrong-but-confident ordering can
score below zero before clamping, so there is no lazy floor to sit on. Partial knowledge
still earns partial credit: getting the podium right but the midfield wrong scores well
above zero.

Karts are matched by name — the character is visible on track and in the ranking icons — so a
submission that gets the order right but mislabels who is who is scored accordingly. Karts
the submission omits are dropped from that race's pairs; a race with fewer than two matched
karts scores 0.

Ground truth is baked verifier-side at /tests/ground_truth.json.
"""
import argparse, json, re
from pathlib import Path

GT_PATH = Path(__file__).with_name("ground_truth.json")
W_FINISH, W_ITEMS = 0.70, 0.30


def norm(s):
    return re.sub(r"[^a-z0-9]", "", str(s).lower())


def as_num(v):
    try:
        return float(v)
    except (TypeError, ValueError):
        return None


def tau(pairs):
    """Normalised Kendall correlation over (gt_value, pred_value) pairs, clamped at 0."""
    n = len(pairs)
    if n < 2:
        return 0.0, 0
    con = dis = total = 0
    for i in range(n):
        for j in range(i + 1, n):
            gi, pi = pairs[i]
            gj, pj = pairs[j]
            dg, dp = gi - gj, pi - pj
            if dg == 0:
                continue          # ground truth ties carry no order to recover, so they are
                                  # excluded from the denominator too — counting them made the
                                  # oracle top out at 0.98 whenever two karts tied on items
            total += 1
            if dp == 0:
                continue          # a predicted tie is neither right nor wrong, but still costs
            if (dg > 0) == (dp > 0):
                con += 1
            else:
                dis += 1
    if total == 0:
        return 0.0, 0
    return max(0.0, (con - dis) / total), total


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--solution", required=True, type=Path)
    ap.add_argument("--reward-json", required=True, type=Path)
    ap.add_argument("--reward-txt", required=True, type=Path)
    a = ap.parse_args()

    gt_races = json.loads(GT_PATH.read_text())["races"]
    reason, pred_races = "ok", []
    try:
        sol = json.loads(a.solution.read_text())
        pred_races = sol.get("races", [])
        if not isinstance(pred_races, list):
            raise ValueError("races is not a list")
    except Exception as exc:  # noqa: BLE001
        reason = f"unreadable solution.json: {exc}"

    per_race, total = [], 0.0
    for i, g in enumerate(gt_races):
        p = pred_races[i] if i < len(pred_races) and isinstance(pred_races[i], dict) else {}
        pk = {norm(k.get("kart")): k for k in p.get("karts", []) if isinstance(k, dict)}
        fin, itm = [], []
        for k in g["karts"]:
            q = pk.get(norm(k["kart"]))
            if not q:
                continue
            pf, pi = as_num(q.get("finish_position")), as_num(q.get("items_collected"))
            if pf is not None:
                fin.append((float(k["finish_position"]), pf))
            if pi is not None:
                itm.append((float(k["items_collected"]), pi))
        t_fin, n_fin = tau(fin)
        t_itm, _ = tau(itm)
        s = W_FINISH * t_fin + W_ITEMS * t_itm
        per_race.append({"track": g.get("track"), "score": round(s, 4),
                         "finish_tau": round(t_fin, 4), "items_tau": round(t_itm, 4),
                         "n_karts": len(g["karts"]), "n_matched": len(fin), "n_pairs": n_fin})
        total += s
    reward = total / max(1, len(gt_races))

    det = {"reason": reason, "n_races": len(gt_races), "n_predicted_races": len(pred_races),
           "per_race": per_race,
           "note": "reward = 0.70*tau(finish order) + 0.30*tau(items order); tau is normalised "
                   "Kendall correlation clamped at 0, so guessing scores 0 in expectation"}
    a.reward_json.parent.mkdir(parents=True, exist_ok=True)
    a.reward_json.write_text(json.dumps({"reward": round(reward, 4), "details": det}, indent=2))
    a.reward_txt.write_text(f"{round(reward, 4)}\n")


if __name__ == "__main__":
    main()

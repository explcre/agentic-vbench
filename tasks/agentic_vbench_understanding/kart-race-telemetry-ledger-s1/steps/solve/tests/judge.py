#!/usr/bin/env python3
"""Grade a SuperTuxKart race-telemetry reconstruction. Pure stdlib, deterministic.

The video is a suite of AI-driven races on different tracks. For each race the agent reports,
per kart: its starting grid slot, where it finished, how many powerup boxes it collected, and
how much nitro it picked up.

Every component is scored as **rank agreement**, not exact match:

    reward =  0.45 * tau(finish order)
            + 0.15 * tau(start grid order)
            + 0.25 * tau(items-collected order)
            + 0.15 * tau(nitro-collected order)

where tau is the normalised Kendall correlation over kart pairs,
`(concordant - discordant) / n_pairs`, clamped at 0.

Which fields are scored is a fairness decision, not a convenience one. Only fields that are
(a) machine-exact in STK's profile table, (b) visible on camera, and (c) dense enough that a
rank has real spread are included: the starting grid, the finishing order (ranking column +
minimap), powerup-box pickups and nitro pickups (both dense, 3-22 per kart). Rescues and
banana hits are in the table too but are almost always zero, so ranking them is neither
discriminative nor guess-proof — they are deliberately NOT scored.

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
# (ground-truth field, prediction field, weight)
DIMS = [("finish_position", "finish_position", 0.45),
        ("start_position",  "start_position",  0.15),
        ("items_collected", "items_collected", 0.25),
        ("nitro_collected", "nitro_collected", 0.15)]


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
        race_score, taus, n_matched = 0.0, {}, 0
        for gt_field, pred_field, w in DIMS:
            pairs = []
            for k in g["karts"]:
                q = pk.get(norm(k["kart"]))
                if not q or gt_field not in k:
                    continue
                pv = as_num(q.get(pred_field))
                if pv is not None:
                    pairs.append((float(k[gt_field]), pv))
            t, _ = tau(pairs)
            taus[gt_field] = round(t, 4)
            race_score += w * t
            n_matched = max(n_matched, len(pairs))
        per_race.append({"track": g.get("track"), "score": round(race_score, 4),
                         "taus": taus, "n_karts": len(g["karts"]), "n_matched": n_matched})
        total += race_score
    reward = total / max(1, len(gt_races))

    det = {"reason": reason, "n_races": len(gt_races), "n_predicted_races": len(pred_races),
           "per_race": per_race, "weights": {f: w for f, _, w in DIMS},
           "note": "reward = sum_field w*tau(field order); tau is normalised Kendall "
                   "correlation clamped at 0, so guessing scores 0 in expectation"}
    a.reward_json.parent.mkdir(parents=True, exist_ok=True)
    a.reward_json.write_text(json.dumps({"reward": round(reward, 4), "details": det}, indent=2))
    a.reward_txt.write_text(f"{round(reward, 4)}\n")


if __name__ == "__main__":
    main()

# Calibration — minecraft-gameplay-ledger-s1 (v4: purposeful pathfinder gameplay)

Order-aware LCS-F1 over (action, target) tokens. Oracle 1.0, empty near 0. GT = the
bot's own mine/kill action order (mineflayer-pathfinder purposeful play: chop trees,
hunt animals, gather). 55 events, first-person, ~10:22.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| degenerate all-"mine oak_log" | 0.44 | known-answer exploit (needs GT distribution) |
| correct multiset, shuffled | 0.62 | see LIMITATION |
| Codex / Antigravity / Claude | _to run_ | |

LIMITATION (verifier strength): a single forest biome yields few, repeated block types
(oak_log/oak_leaves dominant) + a couple mob kinds, so LCS partly measures the multiset
rather than strict order. To harden for the <0.10 bar: a multi-biome route (forest ->
beach -> mountain -> desert) for diverse blocks/ores, more distinct mob types, and
crafting/placing events. The v4 render nails the REAL first-person gameplay look
(pathfinder navigation, chopping trees, hunting); diversity-hardening is the next step.

# Calibration — minecraft-gameplay-ledger-s1 (v7: rich multi-activity gameplay)

Order-aware LCS-F1 over (action, target) tokens. GT = the player's mine/place/kill action
order (mineflayer-pathfinder: explore+chop, hunt 10 animal types, build a house block-by-
block, mine 7 ore types, day->night). **132 events, 29 distinct tokens, max token 20.5%**,
first-person, 10:29, 720p.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| degenerate all-"mine oak_log" | 0.12 | v4 0.44 -> v6 0.17 -> v7 0.12 |
| correct multiset, shuffled | 0.27 | v4 0.62 -> v6 0.41 -> v7 0.27 (order clearly matters) |
| Codex (GPT 5.6-sol) | _to run_ | codex CLI logged in (ChatGPT auth) — ready |
| Antigravity (Gemini 3.x) | _to run_ | agy access TBD |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | installed |

Diversity: 13 block types (incl 7 ores) + 10 mob types + 6 build/place types + house
build. Ablations (single_frame/no_media/frame_dump) to run; no HUD/minimap in render.
Note: night hostile-mob summons missed (find-after-summon), so kills are passive animals;
diversity is already high without them.

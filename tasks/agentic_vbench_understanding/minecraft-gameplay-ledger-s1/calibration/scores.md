# Calibration — minecraft-gameplay-ledger-s1 (v5: diverse purposeful gameplay)

Order-aware LCS-F1 over (action, target) tokens. GT = the bot's mine/kill/place action
order (mineflayer-pathfinder: chop trees, hunt a variety of mobs, gather, build).
73 events, **11 distinct tokens** (max token 29%), first-person, 10:26, 720p.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| degenerate all-"mine oak_log" | 0.29 | vs 0.44 in the low-diversity v4 |
| correct multiset, shuffled | 0.45 | vs 0.62 in v4 — diversity made order matter more |
| Codex / Antigravity / Claude | _to run_ | target <0.10 over 50+ turns |

Ablations (single_frame / no_media / frame_dump) to run; no HUD/minimap in the render.

Diversity levers used: ~8 intended mob types (passive hunts reliable; hostile summons
sometimes miss) + varied blocks (oak/birch logs+leaves, gravel, stone, diorite) + build.
Further hardening for a stricter bar: a multi-biome route (sand/ore/cactus) + reliable
hostile-mob hunts to push distinct tokens up and max-token % down.

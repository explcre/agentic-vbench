# Calibration — minecraft-gameplay-ledger-s1 (v8: multi-biome journey)

Order-aware LCS-F1 over (action, target) tokens. GT = the player's mine/place/kill order
(mineflayer-pathfinder: travels forest → desert → snowy → badlands via /locatebiome+/tp,
builds a house block-by-block, hunts animals, mines 7 ore types, day→night).
112 events, **25 distinct tokens (max 24%)**, first-person, 10:28, 720p.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| degenerate single-token | 0.0–0.2 | guessed block often not even mined |
| correct multiset, shuffled | 0.32 | order matters |
| Codex (GPT 5.6-sol) | _to run_ | codex logged in (ChatGPT Pro) |
| Antigravity / Claude | _to run_ | |

4 maps in one video (forest/desert/snowy/badlands) + house build + 7 ores + 7 animal
types. Note: hostile-mob night summons still miss find-after-summon (kills are animals).

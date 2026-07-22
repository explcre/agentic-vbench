# Calibration — minecraft-build-mine-ledger-s1

Deterministic order-aware LCS-F1 scorer (`steps/solve/tests/judge.py`): F1 = 2·LCS/(|pred|+|gt|)
over the ordered (action, block) token sequence. Clears the bar when every real agent
scores <0.10 over 50+ tool-call turns. Oracle 1.0, empty near 0.

Ground truth: bot /setblock command log = ordered ledger of 80 events (72 place / 8
break) of 11 distinct block types, flat mosaic on grass, prismarine-viewer render, 12:25.

| run | score | notes |
|---|---|---|
| oracle (exact order) | 1.0 | verified locally |
| empty / null | 0.0 | verified locally |
| correct multiset, shuffled order | 0.36 | order matters |
| first-half correct | 0.67 | LCS=40 |
| degenerate (all "place stone") | 0.09 | near-null |
| Codex (GPT 5.6 Sol) | _to run_ | |
| Antigravity (Gemini 3.x) | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | |

## Ablations (each must be <= 0.15)
| ablation | score | notes |
|---|---|---|
| single_frame | _to run_ | one frame gives no ordered sequence |
| no_media | _to run_ | procedural build order not guessable |
| frame_dump_no_tools | _to run_ | ~80 events over 12 min need dense sampling |

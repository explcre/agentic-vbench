# Calibration — pokemon-showdown-bo3-move-ledger-s7

Deterministic F1 scorer (`steps/solve/tests/judge.py`). Clears the bar when every real
agent scores below 0.10 over 50+ tool-call turns. Oracle 1.0, empty near 0.

Ground truth: `tools/p2_pokemon/gen_series.js --seed 7` → Bo3, **388 moves**, move-name
text hidden in the video (movesets revealed in the prompt as a closed vocabulary).

| run | score | rollout (tool-call turns) | notes |
|---|---|---|---|
| oracle | 1.0 | — | verified locally (388/388) |
| empty / null | 0.0 | — | verified locally |
| Codex (GPT 5.6 Sol) | _to run_ | _to run_ | |
| Antigravity (Gemini 3.x) | _to run_ | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | _to run_ | |

## Ablations (each must be <= 0.15)

| ablation | score | notes |
|---|---|---|
| single_frame | _to run_ | expect ~0: no move sequence in one frame |
| no_media | _to run_ | expect ~0: play order is random, not in the teams |
| ocr_text | _to run_ | expect ~0: move-name text bar is hidden at render time |

Raw transcripts in `rollouts/` — one per agent.

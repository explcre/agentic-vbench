# Calibration — sortviz-heapsort-swap-ledger-s7

Deterministic F1 scorer (`steps/solve/tests/judge.py`). A task clears the bar when
**every real agent scores below 0.10** and a real attempt takes **more than 50
tool-call turns**. Oracle must be 1.0 and an empty attempt near 0.

Ground truth: `tools/gen_sortviz.py --seed 7 --n 80` → 269 swaps, 12.2 min, 80 bars.

| run | score | rollout (tool-call turns) | notes |
|---|---|---|---|
| oracle | 1.0 | — | verified locally |
| empty / null | 0.0 | — | verified locally |
| right-pairs / wrong-time dump | 0.0952 | — | verified locally (time tolerance bites) |
| Codex (GPT 5.6 Sol) | _to run_ | _to run_ | |
| Antigravity (Gemini 3.x) | _to run_ | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | _to run_ | |

## Ablations (each must be <= 0.15)

| ablation | score | notes |
|---|---|---|
| single_frame | _to run_ | expect ~0: no sequence in one frame; random pivots ⇒ frame 0 does not determine order |
| no_media | _to run_ | expect ~0: seed/pivots are private, nothing to recall |
| frame_dump_no_tools | _to run_ | expect ~0: 269 events over 12 min, dense tracking needs tool-driven sampling |

Raw transcripts go in `rollouts/` — one file per agent, so a reviewer can confirm each
score was earned honestly and count the tool-call turns.

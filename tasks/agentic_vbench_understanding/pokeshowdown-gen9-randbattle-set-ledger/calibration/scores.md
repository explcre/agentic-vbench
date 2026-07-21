# Calibration — pokeshowdown-gen9-randbattle-set-ledger

Deterministic F1 scorer (`steps/solve/tests/judge.py`). Clears the bar when every real
agent scores < 0.10 over > 50 tool-call turns. Oracle 1.0, empty ~0.

Ground truth: 5 frozen gen9randombattle logs (seeds 7-11) → 115 events over 176 turns.

| run | score | rollout (tool-call turns) | notes |
|---|---|---|---|
| oracle | 1.0 | — | verified locally |
| empty / null | 0.0 | — | verified locally |
| faints-only (drop switch-ins) | 0.6228 | — | verified locally (partial-credit sanity) |
| Codex (GPT 5.6 Sol) | _to run_ | _to run_ | |
| Antigravity (Gemini 3.x) | _to run_ | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | _to run_ | |

Ablations (each must be <= 0.15): single_frame, no_media, frame_dump_no_tools — _to run_.
Raw transcripts in `rollouts/`.

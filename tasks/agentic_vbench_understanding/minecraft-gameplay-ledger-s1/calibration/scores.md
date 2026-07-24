# Calibration — minecraft-gameplay-ledger-s1 (v23)

**Scorer:** `reward = 0.85 · LCS-F1(action, target) + 0.15 · LCS-F1(weapon per kill)`, order-aware.
**Media:** 843 s (14.0 min), 237 events (86 mine / 132 place / 19 kill), 44 distinct block+mob
types, 7 biomes, 3 structures, 1280×720, no audio.

| run | score | turns | tokens | notes |
|---|---|---|---|---|
| oracle | **1.0** | — | — | harness path (`solve.sh` → `judge.py`) |
| correct multiset, shuffled | 0.33 | — | — | order matters |
| single most-common token ×N | 0.11 | — | — | |
| actions right, all targets "stone" | 0.16 | — | — | |
| empty | 0.0 | — | — | |
| **Codex `gpt-5.6-sol` (xhigh)** | **0.4197** | **74** | 4,692,528 | ledger 0.380, weapon 0.643 |
| Antigravity (Gemini‑3.x) | _to run_ | | | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | | | |

Config: `codex exec --dangerously-bypass-approvals-and-sandbox`, Codex CLI v0.145.0,
`model = gpt-5.6-sol`, `model_reasoning_effort = xhigh`, ffmpeg/ffprobe on PATH.
An earlier attempt with a 55-minute cap timed out at 42 turns having written nothing; the run
above was given 2.5 h and told to write the ledger early and refine it.

## Finding: this task is NOT at the <0.10 bar — it is a medium task

Codex scores **0.42**. Where that comes from:

- It reported **89 of 237** events (recall 0.26) but got them largely in the right order
  (LCS 62, precision 0.70). Order-aware LCS-F1 is deliberately generous to a partial-but-correct
  answer, so a confident subset scores 0.38 on the ledger component.
- **`weapon_f1` is 0.643**, the weakest part of the design. The composited HUD highlights the
  held item precisely so the weapon field is answerable — and that same indicator makes it easy
  to read. This is the identical failure mode calibration found in the kart task, where the
  ranking column handed over the finishing order.

There is an inherent tension here that should be stated rather than hidden: several rounds of
work went into making *every* scored action visible on camera (witnessed-kill and
witnessed-placement gates, a mob roster restricted to what the renderer actually draws, a camera
that holds on each block). Fairness demands that. But an action that is clearly visible is also
more identifiable, so the fairness work is part of why the score is 0.42 rather than <0.10.

Options, not yet chosen (the same discipline applied to kart — do not tune the metric until it
passes):
1. **Weight the weapon component down or drop it**, since the HUD is a proxy for it.
2. **Raise recall difficulty**: many more events, and visually-confusable targets (several plank
   and log variants, terracotta shades) so identification is genuinely hard rather than merely
   long.
3. **Accept it as a medium-difficulty entry** at ~0.42.

The proposal issue has deliberately **not** been filed, because claiming "<0.10 for all three
agents" would be false.

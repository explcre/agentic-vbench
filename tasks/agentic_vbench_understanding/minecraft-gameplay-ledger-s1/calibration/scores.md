# Calibration — minecraft-gameplay-ledger-s1 (v30)

**Scorer:** `reward = 0.85 · LCS-F1(action, target) + 0.15 · weapon-F1 over LCS-aligned kills`,
order-aware. The weapon component changed in v30 — see *Scorer correction* below — so **v23 numbers
are not comparable to v30 numbers** and are kept in a separate table.

**Media:** `game_v30.mp4`, sha256 `6096f244…652f51e6f069248997459d9b945d9fde7c00`, 1144 s (19.1 min),
**248 events** (83 mine / 147 place / 18 kill), 44 distinct block+mob types, 8 biomes, 3 structures
(cabin, watchtower, well) + a staircase mine, 1280×720 @ 25 fps, no audio.
2.4% of frames uninformative, mean dominant-colour share 0.242.

## v30 — current scorer

| run | score | turns | tokens | notes |
|---|---|---|---|---|
| oracle | **1.0000** | — | — | harness path (`solve.sh` → `judge.py`); ledger 1.0, weapon 1.0 |
| correct multiset, shuffled | 0.2306 | — | — | order sensitivity, not a shortcut (see below) |
| single most-common token ×N | 0.0685 | — | — | genuine shortcut — under the 0.15 bar |
| actions right, all targets "stone" | 0.0240 | — | — | genuine shortcut — under the 0.15 bar |
| empty | 0.0 | — | — | |
| **Codex `gpt-5.6-sol` (xhigh)** | _running_ | | | fresh run on v30, 2.5 h budget |
| Antigravity (Gemini‑3.x) | _to run_ | | | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | | | |

## Scorer correction found in v30 calibration

The weapon sub-score was an independent LCS-F1 over the kill-weapon sequence. With only **two**
weapon classes that stays high no matter how wrong the ledger is, so it handed out credit nobody
earned:

| ablation | ledger | weapon (old) | reward (old) | weapon (new) | reward (new) |
|---|---|---|---|---|---|
| actions right, targets "stone" | 0.028 | **1.000** | 0.174 | 0.000 | **0.024** |
| correct multiset, shuffled | 0.242 | 0.722 | 0.314 | 0.167 | **0.231** |
| oracle | 1.000 | 1.000 | 1.000 | 1.000 | **1.000** |

Weapon credit is now granted only on kill events inside the ledger's LCS alignment — the weapon of a
kill you never identified is meaningless. The oracle is unaffected, and both genuine shortcuts fall
under the family's 0.15 bar.

**On the shuffled row (0.231):** this is reported as a property, not a failed bar. Reproducing the
exact multiset of 248 events requires watching the whole video; it is most of the work, not a way
around it. The order-aware metric is deliberately generous to a right-but-misordered answer.

## v23 — previous scorer (NOT comparable)

Media was 843 s / 237 events, and the weapon component was scored independently.

| run | score | turns | tokens | notes |
|---|---|---|---|---|
| oracle | 1.0 | — | — | |
| **Codex `gpt-5.6-sol` (xhigh)** | 0.4197 | 74 | 4,692,528 | ledger 0.380, weapon 0.643 |

That 0.4197 is **not** re-scored under the v30 scorer and must not be: the rollout was produced
against a different video and different ground truth, so a rescore would be a number about nothing.
A fresh run is the only honest comparison. (An earlier kart calibration made exactly this mistake —
a rescored rollout reported 0.066 when the targeted run scored 0.335.)

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

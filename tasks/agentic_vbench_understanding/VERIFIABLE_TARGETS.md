---
title: Verifiable targets — agentic_vbench_understanding
summary: Exactly what each understanding-family verifier detects, the output JSON schema, and how it is scored.
read_when: deciding what an agent must extract from a task video, or auditing a task's ground truth and scorer.
---

# Verifiable targets (understanding family)

Every task here is one long video → one JSON the agent writes to
`/workspace/output/solution.json`, graded by a **deterministic** `judge.py` (no LLM judge)
against a machine-generated `ground_truth.json` baked verifier-side. Oracle = 1.0, blind/empty
≈ 0. This file lists, per task, the exact fields the verifier reads and the metric.

Each task dir also carries a `SPEC.md` (full card) and the authoritative `steps/solve/tests/judge.py`.

---

## minecraft-gameplay-ledger-s1  — first-person gameplay ledger

**Detects:** the ordered list of the player's deliberate actions.

```json
{"events": [
  {"action": "mine",  "target": "oak_log"},
  {"action": "kill",  "target": "cow",   "tool": "sword"},
  {"action": "place", "target": "stone_bricks"},
  {"action": "kill",  "target": "chicken", "tool": "bow"}
]}
```

| field | values | evidence in video |
|---|---|---|
| `action` | `mine` \| `place` \| `kill` | camera turns to each block; combat for kills |
| `target` | block type (mine/place) or mob type (kill), closed vocab of 44 | rendered block/mob texture |
| `tool` | `sword` \| `bow` — required on `kill` | held item in HUD + engagement distance |

**Metric:** `reward = 0.85 · LCS-F1(action,target order) + 0.15 · LCS-F1(kill-weapon order)`.
Order-aware (moving camera, variable-FPS render). Oracle 1.0; shuffled 0.35; single-token 0.10.
Fairness gates: only renderer-visible mobs in the vocab; every scored kill and placement was
verified on-camera during generation.

---

## kart-race-telemetry-ledger-s1  — SuperTuxKart powerup counting
> **Authoritative copy lives on branch `pengchx-kart-race-telemetry`, not here.** That branch is
> the focused contribution (task only, cut from `main`) and is the single source of truth for the
> kart task; this section is a summary that may lag it. The task directory was deliberately
> removed from this branch so the two copies cannot drift — it had already fallen two scorer
> generations behind once.

**Detects:** per race, how many powerup boxes each kart collected.

```json
{"races": [
  {"track": "hacienda", "karts": [
    {"kart": "amanda", "items_collected": 17},
    {"kart": "tux",    "items_collected": 10}
  ]}
]}
```

| field | values | evidence in video |
|---|---|---|
| `kart` | character name, closed set of 18 | on-track character + ranking-column icon |
| `items_collected` | int — **the only scored field** | kart drives through a question-mark box |
| `nitro_collected`, `finish_position`, `start_position`, `track` | optional, **not scored** | see below |

**Metric:** `reward = max(0, mean_races[tau(items_collected)])`, signed Kendall tau over kart
pairs aggregated then clamped once. Guessing → 0 in expectation. Karts matched by name;
ground-truth ties excluded from tau.

**Why only this field is scored** — calibration showed the others are readable rather than
counted: the ranking column and starting grid *display* finish and start (Codex tau 0.75 / 0.90),
and nitro *use* shows as boost flames (tau ~0.32 vs ~0.07 on items). Only the powerup-box count
has no on-screen proxy. Details in that task's `SPEC.md` and `calibration/scores.md`.

---

## pokemon-showdown-bo3-move-ledger-s7  — battle move ledger

**Detects:** every move used, per game / turn / side.

```json
{"moves": [{"game": 1, "turn": 3, "side": "Red", "move": "Thunderbolt"}]}
```

| field | values | evidence |
|---|---|---|
| `game` | 1..3 (best-of-three) | game header |
| `turn` | int (scored with ±1 tolerance) | turn counter |
| `side` | `Red` \| `Blue` | which side acted |
| `move` | move name from the closed per-battle vocab | animation; move-name text is hidden, movesets given as vocab |

**Metric:** F1 over `(game, turn±1, side, move)` tuples. `reward = F1`. Misses and inventions both hurt.

---

## music-transcription-ledger-s7  — audio-visual note transcription

**Detects:** every note's pitch and onset. (The one task where **audio is required**.)

```json
{"notes": [{"t": "0:04.5", "pitch": "C4"}]}
```

| field | values | evidence |
|---|---|---|
| `t` | seconds or `mm:ss` (matched within TOL) | falling-notes bar reaches the now-line |
| `pitch` | MIDI int or scientific name (`C4`, `F#5`) | the heard tone (axis is unlabelled, so pitch needs audio) |

**Metric:** a predicted note is a true positive when an unused GT note has the same pitch and
onset within `TOL` seconds. `reward = F1`. Designed so audio-alone (overlapping voices) and
video-alone (no timbre) both fall short of using both.

---

## gsw-cle-2018-finals-g4-three-point-timeline  — event-spotting timeline

**Detects:** the timestamps of every made three-pointer across a long game video.

```json
{"threes": [{"t": "12:34"}]}
```

| field | values | evidence |
|---|---|---|
| `t` | timestamp (matched within tolerance) | shot + scoreboard change |

**Metric:** F1 over made-three timestamps (misses and false positives both hurt). `reward = F1`.
~20 made threes scattered across ~2.5 hours → long-horizon event spotting.

---

## Common contract

- Output path `/workspace/output/solution.json`; verifier writes `reward.json` + `reward.txt`.
- All scorers are pure stdlib and deterministic; the same submission always scores the same.
- Ground truth is machine-generated (engine logs, sim state, or the bot's own action events),
  never hand-annotated, so the oracle provably scores 1.0 through the harness path
  (`steps/solve/solution/solve.sh` → `steps/solve/tests/judge.py`).

---
title: Task Spec Card
summary: pokemon-showdown-bo3-move-ledger-s7 — reconstruct every move in a Bo3 random-battle series.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/pokemon-showdown-bo3-move-ledger-s7

# 1. Cognitive level.
cognitive_level: reasoning
# The move-name text is hidden, so each move must be inferred from its animation, the
# resulting HP change, and status/stat effects, then matched to one of the four known
# moves of the acting Pokemon. That is cross-signal inference, not a lookup.

# 2. Modalities required.
modalities_required:
  video: The per-turn move sequence exists only across frames (animation + HP deltas).
  audio: not used.

# 3. Question and output schema.
question: For every turn of every game in the Bo3 series, which move did each side use?
output_schema: >
  {"moves": [{"game": 1-3, "turn": int, "side": "Red"|"Blue", "move": <name from vocab>}]}
  scorer turn tolerance = 1.

# 4. Evidence chain (temporally distributed by construction).
evidence:
  - "388 moves across 3 games, each at a distinct on-screen turn"
  - "move identity needs animation + HP-bar delta + status/stat cues, cross-referenced
     against the acting Pokemon's 4-move set"
  - "game boundaries marked by GAME 1/2/3 title cards"

# 5. Ground truth.
ground_truth:
  source: pokemon-showdown 0.11.10 simulator move log (tools/p2_pokemon/gen_series.js, base seed 7).
  tier: machine-truth
  verification: >
    The oracle solution.json is emitted from the same seeded series that renders the
    video and scores 1.0 (388/388) against ground_truth.json locally. Movesets shown to
    the agent are the exact sets the simulator assigned. Video and ledger share one seed.

# 6. Scorer.
scorer:
  metric: >
    F1 over moves. TP iff an unused GT move matches on game, side, normalised move name,
    and turn within 1. Each GT move matches at most one prediction.
  oracle_reward: 1.0
  null_reward: 0.0

# 7. Difficulty (measured).
difficulty:
  strong_agent_reward: TBD
  tool_call_turns: TBD
  agent_model: TBD

# 8. Anti-shortcut ablations (each <= 0.15).
anti_shortcut:
  single_frame: TBD   # one frame gives no sequence
  no_media: TBD       # random play order is not derivable from the revealed teams
  ocr_text: TBD       # the move-name message bar is removed at render time
  frame_dump_no_tools: TBD

# 9. Input media.
input:
  url: HF dataset (to upload): understanding-materials/pokemon-showdown-bo3-move-ledger-s7/game.mp4
  sha256: filled into environment/Dockerfile after render
  length_min: 10.7
  resolution: 720
```

## Notes on shortcut resistance

- **Move text removed.** The `.messagebar`/`.message` layer that prints "X used Y!" is
  hidden by CSS at render time, so moves cannot be OCR'd — only inferred from animation
  and HP change. Verified by inspecting rendered frames.
- **Fair naming.** Because names are unreadable on screen, the prompt reveals each
  Pokemon's four-move set as a closed vocabulary; the agent classifies each observed
  move into that set. A path exists (so the task is well-posed) but it is hard.
- **Not derivable from the teams.** Random-move play means the move *order* is private
  entropy; knowing the movesets does not give the sequence.
- **Dump defense.** Emitting many guesses per turn craters precision (388 GT moves) → F1 ≈ 0.

---
title: Task Spec Card
summary: pokeshowdown-gen9-randbattle-set-ledger — reconstruct switch-in/faint timeline across 5 muted battles.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/pokeshowdown-gen9-randbattle-set-ledger

cognitive_level: understanding
# Track Pokemon identity (species from sprite) and side across many entrances/faints
# over 5 battles and order them in time. Not a single-state read.

modalities_required:
  video: The answer is the temporal sequence of switch-ins and faints across games;
         it exists only across frames (sprite changes + HP bars + turn counter).
  audio: not used (video is muted).

question: Reconstruct, across all 5 battles, every switch-in and faint, tagged with
          game, turn, side, and species.
output_schema: >
  {"events": [{"game":1-5, "turn":int, "side":"p1|p2", "event":"switch_in|faint",
  "species":str}, ...]}. Scorer turn tolerance = 1.

evidence:
  - "battle scene: sprite on each side identifies the active species"
  - "HP bar hitting zero + sprite leaving field = faint"
  - "title cards segment the 5 games; on-screen turn counter times each event"
  - "events span ~176 turns across 5 games — temporally distributed by construction"

ground_truth:
  source: pokemon-showdown gen9randombattle protocol logs (frozen, seeds 7-11),
          parsed by tools/p2_pokemon/parse_ledger.py.
  tier: machine-truth
  verification: >
    The ledger is parsed directly from the simulator's own |switch|/|drag|/|faint|/
    |turn| lines. The video is rendered from the SAME frozen logs, so ledger and video
    cannot drift. Oracle solution.json scores 1.0 against ground_truth.json (verified).

scorer:
  metric: >
    F1 over events. TP iff an unused GT event matches on (game, side, event type,
    normalized species) with |turn_pred - turn_gt| <= 1. Each GT event matches once.
  oracle_reward: 1.0
  null_reward: 0.0   # empty list; faints-only partial = 0.62 (verified)

difficulty:
  strong_agent_reward: TBD
  tool_call_turns: TBD
  agent_model: TBD

anti_shortcut:
  single_frame: TBD   # expect ~0: one frame gives no timeline
  video_only: n/a     # already muted
  audio_only: n/a
  no_media: TBD       # expect ~0: private seeds, nothing to recall
  frame_dump_no_tools: TBD

input:
  url: HF dataset (to upload after render)
  sha256: REPLACE_AFTER_RENDER
  length_min: TBD (target > 10 after render)
  resolution: 720
```

## Shortcut resistance

- **Text log hidden.** The move/event text ("Red's Pikachu used ...") appears only in
  the Showdown log panel, which the render omits. The task deliberately does NOT score
  move names (unreadable from the muted scene); it scores structural events readable
  from sprites + HP bars.
- **Not recall / not single-frame.** Private battle seeds; the sequence spans 176 turns.
- **Dump defense.** F1 with each GT event matched once → flooding predictions craters
  precision.

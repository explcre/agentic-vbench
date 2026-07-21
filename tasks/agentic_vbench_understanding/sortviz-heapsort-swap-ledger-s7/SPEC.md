---
title: Task Spec Card
summary: sortviz-heapsort-swap-ledger-s7 — reconstruct every swap in a silent bar-sort animation.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/sortviz-heapsort-swap-ledger-s7

# 1. What kind of thinking does this task need?
cognitive_level: understanding
# The agent must track object identity (which bar is which, by height rank) across
# hundreds of position changes and order the events in time — not read off a single
# state. It relates each swap to the two specific bars involved.

# 2. Which modalities are REQUIRED?
modalities_required:
  video: The entire answer is the temporal sequence of position swaps; it exists only
         across frames. No single frame contains it.
  audio: not used (video is silent).

# 3. The exact question and output schema.
question: Reconstruct the ordered ledger of every position swap in the animation,
          each as the pair of bar height-ranks that exchanged places and its time.
output_schema: >
  {"swaps": [{"t": "mm:ss" (or seconds), "bars": [rank_a, rank_b]}, ...]}
  ranks are 1 (shortest) .. 80 (tallest); pair order does not matter; scorer
  tolerance is 3.0 s on t.

# 4. Evidence chain (temporally distributed by construction).
evidence:
  - "t≈2s..t≈730s, video: each of the 269 swaps is a distinct event at a distinct time"
  - "identity requires comparing a bar's height against all others (global rank), not a
     local read"
  - "no on-screen text, numbers, or algorithm name — nothing to OCR"

# 5. Ground truth.
ground_truth:
  source: tools/gen_sortviz.py emits the exact swap ledger it renders (seed 7, n 80).
  tier: machine-truth
  verification: >
    The generator asserts the array is sorted after applying exactly the logged swaps;
    the oracle solution.json is emitted from the same run, and judge.py scores it 1.0
    against ground_truth.json (verified locally). Video and ledger cannot drift because
    both come from one seeded run.

# 6. Scorer: deterministic code only.
scorer:
  metric: >
    F1 over swaps. A predicted swap is a TP iff an unused GT swap has the same unordered
    rank-pair AND |t_pred - t_gt| <= 3.0 s. Each GT swap matches at most one prediction.
  oracle_reward: 1.0
  null_reward: 0.0   # empty list; a right-pairs/wrong-time dump scores ~0.10

# 7. Difficulty: measured with a real strong-agent run.
difficulty:
  strong_agent_reward: TBD   # to run: Codex, Antigravity, Claude
  tool_call_turns: TBD
  agent_model: TBD

# 8. Anti-shortcut ablations (each must be <= 0.15).
anti_shortcut:
  single_frame: TBD  # expected ~0: one frame gives no swap sequence, and the random
                     #   pivots mean the initial arrangement does not determine the order
  video_only: n/a    # already silent
  audio_only: n/a
  no_media: TBD      # expected ~0: nothing to recall; the seed/pivots are private
  frame_dump_no_tools: TBD

# 9. Input media.
input:
  url: HF dataset (to upload): understanding-materials/sortviz-heapsort-swap-ledger-s7/game.mp4
  sha256: see game.sha256 (filled into environment/Dockerfile)
  length_min: 12.2
  resolution: 720
```

## Notes on shortcut resistance

- **Not simulable from frame 0.** A deterministic sort is a pure function of the initial
  array, so one frame + simulation would solve it. This task uses a **random-pivot
  quicksort**; the pivot choices are private entropy, so the swap order is not
  recoverable without watching. This is the whole reason the algorithm is randomized.
- **No graphics shortcut.** Bars are uniform-colour, unlabeled; there is no scoreboard,
  no counter, no algorithm name. Identity is height rank, forcing global comparison.
- **Dump defense.** Emitting all possible pairs at all times craters precision (269 GT
  swaps vs thousands of predictions) → F1 ≈ 0. Correct pairs with wrong times ≈ 0.10.

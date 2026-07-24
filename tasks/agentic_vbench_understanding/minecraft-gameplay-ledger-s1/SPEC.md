---
title: Task Spec Card
summary: minecraft-gameplay-ledger-s1 — reconstruct a player's action ledger, with the weapon used per kill, from a first-person Minecraft session.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/minecraft-gameplay-ledger-s1

cognitive_level: understanding
# Follow a moving first-person session across seven biomes and reconstruct the ordered
# sequence of deliberate actions — 211 actions over 10.9 minutes — including which weapon
# was used for each kill.

modalities_required:
  video: the action sequence exists only across frames of the first-person view.
  audio: not used.

question: Reconstruct the player's ordered action ledger (mine/place block-type, kill mob-type + weapon).
output_schema: '{"events": [{"action": "mine"|"place"|"kill", "target": <block/mob>, "tool": "sword"|"bow"}]}'

ground_truth:
  source: the mineflayer bot's own events (dig completion, entity death) plus its own
          /setblock placements; Paper 1.16.5 generated world.
  tier: machine-truth
  verification: oracle solution.json = the bot's action order; judge.py scores it 1.0.

scorer:
  metric: "0.85 * LCS-F1 over ordered (action,target) + 0.15 * LCS-F1 over ordered kill weapons."
  oracle_reward: 1.0
  null_reward: 0.0
  measured_ablations:      # same GT, deliberately wrong submissions
    shuffled_ledger: 0.35  # right multiset, wrong order
    single_token_xN: 0.10  # most common token repeated
    targets_wrong: 0.16    # actions right, every target replaced by "stone"

difficulty: {strong_agent_reward: TBD, tool_call_turns: TBD, agent_model: TBD}

anti_shortcut:
  most_common_token_xN: 0.069   # the single commonest (action, target), repeated
  actions_right_targets_stone: 0.024
  correct_multiset_shuffled: 0.231   # order sensitivity, not a shortcut — see Known limitations
  empty: 0.0

input:
  url: https://huggingface.co/datasets/explcre/agenticvbench-understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/game_v30.mp4
  sha256: 6096f2448205fb08fec8542fbead652f51e6f069248997459d9b945d9fde7c00
  length_min: 19.1
  resolution: 720
  contents: 248 events (83 mine, 147 place, 18 kill); 44 distinct block/mob types;
            biomes forest, beach, desert, snowy tundra, jungle, plains, savanna, badlands;
            3 structures built on camera (cabin, well, watchtower); a staircase mine.
```

## Notes

- **Real first-person gameplay** — a moving player, real mining with the camera turning to
  each block, sword and bow combat, and structures assembled block by block. Real-life
  analog: gameplay/instructional-video analysis and embodied-agent behaviour verification.
  Distinct from VPT/MineRL frame-level inverse dynamics: this is long-horizon and
  event-level, not per-frame action regression.
- **Order-based scoring** handles the moving camera and the variable-FPS software render.
  Video time was verified to be an exact offset of event time (checked against two landmarks
  64 s apart), but order remains the scored quantity.
- **The HUD is the real game HUD, and it is evidence.** It is composited from the actual
  Minecraft GUI sprites shipped with prismarine-viewer (`gui/widgets.png` hotbar and
  selector, `gui/icons.png` hearts / hunger / XP bar, the real 16x16 item textures) at
  vanilla geometry — GUI scale 3, hotbar at x=centre-91 and y=height-22, hearts at y=-39,
  XP at y=-32. The highlighted slot tracks the item the player actually held at that moment,
  from the bot's own held-item timeline, so the weapon component is answerable rather than
  guessable. The held item is also drawn first-person in the lower right, and two effects the
  renderer omits are composited back from the event log: the vanilla block-break crack grows
  over each dig, and a red hit-flash marks each kill (timing exact; placement centre-anchored
  because the camera is aimed at the target when it acts).

## Fairness constraints enforced during generation

Each was found by inspecting frames, and each would otherwise have put unanswerable rows
into the ground truth.

1. **Only mobs this renderer actually draws are in the vocabulary.** An audit of 27 mobs
   found 11 render (`tools/p1_minecraft/MOB_RENDER_AUDIT.md`): zombies, skeletons, creepers,
   spiders, villagers, foxes, rabbits, horses and llamas are invisible even though the entity
   exists and the camera tracks it. Earlier drafts scored kills on invisible mobs.
2. **Every scored kill was witnessed.** A kill is recorded only if the mob was present and in
   range for several consecutive attack ticks with the camera on it. An earlier session
   contained a panda kill that happened entirely off camera. In the shipped session, 0 of 25
   kills were rejected by this gate.
3. **Every scored placement was witnessed.** Before each block the player backs off and, if
   the block is not in frame, walks around to that block's own side of the structure — which
   is also how a person builds. A block that still cannot be framed is placed (so the
   building completes) but excluded from the ledger. In the shipped session 5 placements were
   excluded this way.
4. **No blind-guessable runs.** Build palettes alternate within each layer and the mine is cut
   through layered strata, so long runs of one repeated block no longer dominate the ledger —
   closing the earlier weakness where a plausible-house guess partly matched.

## Known limitations

- Order-aware scoring still leaves part of the reward recoverable from the target multiset
  alone; the shuffled-ledger ablation at **0.231** quantifies that ceiling. This is reported as a
  property, not a shortcut: reproducing the exact multiset of 248 events requires watching the whole
  video, so it is most of the work rather than a way around it. The genuine shortcuts —
  most-common-token (0.069) and actions-right-targets-wrong (0.024) — are both well under 0.15.
- **Weapon credit is gated on ledger alignment.** Scoring the kill-weapon sequence independently was
  nearly free, because there are only two weapon classes: a submission that named every block
  "stone" scored ledger 0.028 and weapon 1.000, reaching reward 0.174. Weapon credit is now granted
  only on kills inside the ledger's LCS alignment, which drops that ablation to 0.024 and leaves the
  oracle at exactly 1.0.
- **The closed vocabulary is asserted against the ledger at build time.** The staircase mine records
  the real blocks it digs, so the vocabulary must cover the terrain of every biome on the route, not
  just the gather categories. `build_p1_gt_v11.py` refuses to emit a task whose ground truth contains
  an unlisted target — it caught `brown_terracotta` in badlands on a real session.
- 2.4% of frames are dominated by a single colour (distant vistas and sky), measured with
  `tools/p1_minecraft/frame_audit.py`; mean dominant-colour share is 0.242. Run-to-run variation on
  that metric is ±1–2 points and is driven by spawn terrain, so it is reported rather than optimised
  against.
- **Every structure is verified visible from the camera.** The generator raycasts to each finished
  build and checks the first block hit belongs to it, logging `ORBIT_SHOWN n/m`: v30 records 6/6 for
  the cabin, 5/5 for the watchtower and 5/5 for the well. Placements the camera missed are not
  silently written into the world — they are deferred and placed for real on camera in a second pass
  (v30: 49 recovered, 0 residual), so nothing exists in the finished build that is absent from the
  ledger.

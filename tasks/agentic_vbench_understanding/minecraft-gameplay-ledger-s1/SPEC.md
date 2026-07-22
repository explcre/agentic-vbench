---
title: Task Spec Card
summary: minecraft-gameplay-ledger-s1 — reconstruct a player's action ledger from first-person Minecraft gameplay.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/minecraft-gameplay-ledger-s1

cognitive_level: understanding
# Follow a moving first-person session and reconstruct the ordered sequence of deliberate
# actions (mine which block / kill which mob) across ~90 actions over ~10 minutes.

modalities_required:
  video: the action sequence exists only across frames of the first-person view.
  audio: not used.

question: Reconstruct the player's ordered action ledger (mine block-type / kill mob-type).
output_schema: '{"events": [{"action": "mine"|"kill", "target": <block/mob type>}]}'

ground_truth:
  source: the mineflayer bot's own action events (dig completion, entity death), generated world seed 88.
  tier: machine-truth
  verification: oracle solution.json = the bot's action order; judge.py scores it 1.0.

scorer:
  metric: "order-aware LCS F1 = 2*LCS/(|pred|+|gt|) over (action,target) tokens."
  oracle_reward: 1.0
  null_reward: 0.0

difficulty: {strong_agent_reward: TBD, tool_call_turns: TBD, agent_model: TBD}

anti_shortcut:
  single_frame: TBD
  no_media: TBD    # this session's block distribution is not knowable blind
  frame_dump_no_tools: TBD

input:
  url: HF (to upload): understanding-materials/minecraft-gameplay-ledger-s1/game.mp4
  sha256: see environment/Dockerfile
  length_min: 10.0
  resolution: 720
```

## Notes

- **Real first-person gameplay** (generated world, moving player, real mining with the
  camera turning to each block, mob combat) — reconstruct *what the player did* from the
  footage. Real-life analog: gameplay/instructional-video analysis, embodied-agent
  behaviour verification. Distinct from VPT/MineRL frame-level inverse dynamics.
- **Order-based** scoring handles the moving camera and variable-FPS render.
- **KNOWN LIMITATION (verifier strength):** natural mining yields few, repeated block
  types (6 here), so LCS partly measures the block multiset; shuffled GT still scores
  ~0.56. To make it clearly hard + order-sensitive, increase block-type diversity (a
  scripted varied session across materials, or a richer action vocabulary). Tracked.

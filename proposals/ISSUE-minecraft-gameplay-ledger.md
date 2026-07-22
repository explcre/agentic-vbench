# [Task Proposal] Minecraft first-person gameplay action-ledger reconstruction

**Family:** `agentic_vbench_understanding` · **Proposed task id:** `minecraft-gameplay-ledger-s1`

## Is it hard enough / long-horizon?
A ~10-minute **first-person** Minecraft session: a player explores a world, mines many
blocks of several types, hunts a variety of mobs, and builds — ~80 deliberate actions,
**no HUD or text overlay**. Reconstructing the *ordered* action ledger requires watching
the whole video, identifying each block/mob by its rendered texture, and ordering ~80
events. A single frame, one modality, or a schema guess cannot recover it; a strong agent
needs 50+ tool calls and still scores low. Real-world analog: analyzing gameplay/instruc-
tional footage and verifying an embodied agent's behavior.

## Cognitive level
**understanding** — track object identity (block type / mob type) and event polarity, and
order ~80 events across ~10 minutes. Not a lookup.

## Modalities required
- **video** — required; the ledger exists only across frames (block breaking, camera
  turning to it, a mob being struck).
- **audio** — not used (silent render).

## Question & output schema
> Reconstruct, in chronological order, the player's deliberate actions: every block
> **mined** (block type) and every mob **killed** (mob type).
```json
{ "events": [ {"action": "mine"|"kill", "target": "<block or mob type>"} ] }
```
`target` ∈ closed vocab — blocks: oak_log, birch_log, spruce_log, oak_leaves, birch_leaves,
grass_block, dirt, sand, gravel, stone, cobblestone, granite; mobs: cow, pig, sheep,
chicken, rabbit, zombie, skeleton, spider. **Order** is scored (LCS), not timestamps.

## Evidence chain
- t≈0–600 s, video: ~80 actions, each a distinct event at a distinct time (chop a tree,
  dig terrain, strike a mob), spread across the whole session.
- identity needs the rendered texture (no labels); order needs following the first-person
  view across the video (≥2 far-apart moments trivially required).

## Ground truth
- **source:** the bot's own engine action events (mineflayer `diggingCompleted` /
  entity-death) — the exact executed sequence.
- **tier:** machine-truth.
- **verification:** oracle `solution.json` = the engine's action log; scorer scores it 1.0.
  Video + ledger come from one seeded session, so they cannot drift.

## Scorer (deterministic)
Order-aware **LCS F1** over `(action, target)` tokens: `F1 = 2·LCS/(|pred|+|gt|)`. Misses,
inventions, wrong types, reorderings all lower it. **oracle=1.0, empty=0.0** (verified).
High diversity (varied blocks + ~8 mob types + build; no single token > ~20%) makes the
multiset non-guessable, so shuffled/single-token answers score low.

## Difficulty (to calibrate)
Codex (GPT‑5.6), Antigravity (Gemini‑3.x), Claude Code (Fable 5 / Opus 4.8); target **<0.10**
for all three over **>50** tool-call turns. Raw trajectories saved per harness in
`calibration/rollouts/`.

## Anti-shortcut ablations (each ≤ 0.15)
- **single_frame** — one frame gives no ordered sequence.
- **no_media** — procedurally played; its event distribution is not knowable blind.
- **frame_dump_no_tools** — ~80 events over 10 min need active seeking/sampling.
- HUD/minimap: none (prismarine-viewer first-person renders only the world).

## Input media
- **url:** self-hosted on HF (rendered mp4; not scraped → no famous-footage leakage).
- **sha256:** pinned in `environment/Dockerfile`. **length:** ~10 min. **resolution:** 720p.

## Why it's novel (paper context)
Freshly rendered (zero dataset overlap). Distinct from VPT/MineRL frame-level inverse
dynamics: long-horizon, high-level, *ordered* event-ledger reconstruction with a
deterministic verifier — the AgenticVBench thesis, not behavior cloning.

## Reproducibility
Regenerable from a seed: `tools/p1_minecraft/` (Paper 1.16.5 + mineflayer-pathfinder bot
`bot_play3.js` + prismarine-viewer first-person + ffmpeg). No manual annotation.

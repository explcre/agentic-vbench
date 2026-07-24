# [Task Proposal] Minecraft first-person gameplay action-ledger reconstruction

**Family:** `agentic_vbench_understanding` · **Proposed task id:** `minecraft-gameplay-ledger-s1`

## Is it hard enough / long-horizon?
A **14-minute first-person** Minecraft session: the player crosses seven biomes, gathers many
block types, builds three structures on camera (a cottage with a peaked roof, a village well, a
watchtower), fights animals with **both a sword and a bow**, takes a boat, and finally digs a
staircase mine through layered rock for every ore. That is **248 deliberate actions over 44
distinct block and mob types**. Reconstructing the *ordered* ledger means watching the whole
video, naming each block/mob from its rendered texture, telling apart the weapon used for each
kill, and getting the order right. A single frame, one modality, or a schema guess cannot
recover it. Real-world analog: analysing gameplay/instructional footage and verifying an
embodied agent's behaviour.

## Cognitive level
**understanding** — track object identity (block type / mob type), action type, and the weapon
used, and order 248 events across 19 minutes. Not a lookup.

## Modalities required
- **video** — required; the ledger exists only across frames (block breaking, camera
  turning to it, a mob being struck).
- **audio** — not used (silent render).

## Question & output schema
> Reconstruct, in chronological order, every block **mined**, every block **placed**, and every
> mob **killed** — with the **weapon** used for each kill.
```json
{ "events": [ {"action": "mine"|"place"|"kill", "target": "<block or mob>", "tool": "sword"|"bow"} ] }
```
`target` ∈ a closed 44-entry vocab (logs, leaves, terrain, ores, building materials; mobs: cow,
pig, sheep, chicken, wolf, mooshroom, polar_bear, turtle, panda). `tool` is required on kills.
**Order** is scored (LCS), not timestamps.

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
`reward = 0.85 · LCS-F1(action, target) + 0.15 · LCS-F1(weapon of each kill)`, order-aware:
`F1 = 2·LCS/(|pred|+|gt|)`. Misses, inventions, wrong types and reorderings all lower it.
Measured on the shipped ground truth: **oracle 1.0** (through the harness path), correct
multiset but shuffled **0.33**, single most-common token repeated **0.11**, actions right with
every target wrong **0.16**, empty **0.0**.

## Difficulty (to calibrate)
Codex (GPT‑5.6), Antigravity (Gemini‑3.x), Claude Code (Fable 5 / Opus 4.8); target **<0.10**
for all three over **>50** tool-call turns. Raw trajectories saved per harness in
`calibration/rollouts/`.

## Anti-shortcut ablations
- **single_frame** — one frame gives no ordered sequence.
- **no_media** — procedurally played; the event distribution is not knowable blind (single-token
  **0.069**, wrong-targets **0.024** measured — both under the 0.15 bar).
- **frame_dump_no_tools** — 248 events over 19 min need active seeking/sampling.
- **shuffled** **0.231** — build palettes alternate *within* each layer and the mine cuts layered
  strata, so there is no long run of one block for a "plausible build" guess to match. This row is
  order sensitivity rather than a shortcut: reproducing the exact multiset of 248 events means
  watching the whole video.
- **Weapon credit is gated on ledger alignment.** Scored independently it was nearly free (two
  classes only): a submission naming every block "stone" reached weapon 1.000 on a 0.028 ledger.
  Credit now requires the kill to sit inside the ledger's LCS alignment, which is what moves the
  wrong-targets ablation to 0.024 while leaving the oracle at exactly 1.0.
- The HUD shows hearts/hunger/XP and the selected hotbar slot, but **no action log and no block
  or mob labels**, so it never states an answer; the held-weapon indicator is the intended
  evidence for the `tool` field.

## Input media
- **url:** `https://huggingface.co/datasets/explcre/agenticvbench-understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/game_v30.mp4`
  (self-rendered, self-hosted; not scraped → no famous-footage leakage).
- **sha256:** `6096f2448205fb08fec8542fbead652f51e6f069248997459d9b945d9fde7c00`, pinned in
  `environment/Dockerfile` and verified with the same fetch the Docker build performs.
- **length:** 19.1 min. **resolution:** 1280×720. **audio:** none — deliberately, since
  Minecraft's break sounds are material-specific and its hurt sounds species-specific, so audio
  would hand over the block and mob identities the task is asking for.

## Programmatic large-scale generation ⭐
This is a **generator**, not a single clip. `tools/p1_minecraft/bot_play8.js` plays a
parameterised session (biomes visited, structures built, mob roster, tool use) on a seeded
world; render → ground truth is one command with zero annotation. The space of distinct,
machine-labeled sessions is effectively unlimited (seed × biome route × build set × mob mix),
so the benchmark can mint an arbitrary number of fresh instances, hold out unseen
combinations, and re-generate if a clip ever leaks — the anti-overfitting property the paper
wants. Every scored event is machine-truth from the engine, so scale costs no labeling.

## Why it's novel (paper context)
Freshly rendered (zero dataset overlap). Distinct from VPT/MineRL frame-level inverse
dynamics: long-horizon, high-level, *ordered* event-ledger reconstruction with a
deterministic verifier — the AgenticVBench thesis, not behavior cloning.

## Fairness constraints enforced during generation
Each was found by inspecting frames, and each would otherwise have put **unanswerable rows** in
the ground truth:
1. **Only mobs the renderer actually draws are in the vocabulary.** An audit of 27 mobs found 11
   render; zombies, creepers, villagers, foxes, rabbits, horses and llamas draw as *nothing* even
   though the entity exists and the camera tracks it. Earlier drafts scored kills on invisible
   mobs.
2. **Every scored kill and placement was witnessed.** A kill counts only if the mob was in range
   with the camera on it for several consecutive attack ticks; a block counts only if it was in
   frame, and the player walks round to a block's own side to place it. An earlier session
   contained a panda kill that happened entirely off camera.
3. **Nothing exists in the finished build that is absent from the ledger.** The converse of (2)
   matters just as much: blocks the camera missed used to be written into the world anyway, so the
   finished cabin contained ~33% of blocks (median 86° off-axis) that were *not* in the ground
   truth, and an agent listing what it watched was penalised for them. They are now **deferred** and
   placed for real on camera in a second pass — 49 recovered, **0 residual**, in four camera moves.
4. **Every structure is verified visible.** The generator raycasts to each finished build and checks
   the first block hit belongs to it, logging `ORBIT_SHOWN n/m` (v30: cabin 6/6, watchtower 5/5,
   well 5/5). Build sites must also be flat and tree-free — no log or leaf in the footprint, ≥85% of
   columns within one block, spread ≤3 — otherwise walls end up half-buried or screened by canopy.
5. **The closed vocabulary is asserted against the ledger at build time.** The staircase mine records
   the real blocks it digs, so the vocabulary must cover the terrain of every biome on the route, not
   just the gather categories. The builder refuses to emit a task whose ground truth contains an
   unlisted target — it caught `brown_terracotta` in badlands on a real session.
6. **No blind-guessable runs** (see shuffled ablation above).

## Reproducibility
Regenerable from a seed: `tools/p1_minecraft/` (Paper 1.16.5 + mineflayer-pathfinder bot
`bot_play8.js` + prismarine-viewer first-person + ffmpeg). No manual annotation. The HUD, the
vanilla block-break crack and the hit-flash are composited from the *real* game assets at the
bot's own event times, because the headless renderer draws none of them.

## Two renderers, one bot
The same `bot_play8.js` also drives the **real Minecraft Java client** (1.20.4, joined via
`--quickPlayMultiplayer`, camera locked to the bot with `/spectate`), which draws cracks, hurt
flashes, hand swing, particles and sound natively — nothing composited but the HUD, since a
spectator has none. A working sample is
[`authentic_java_1204_v2.mp4`](https://huggingface.co/datasets/explcre/agenticvbench-understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/authentic_java_1204_v2.mp4)
(234 s, 114 machine-exact events, 0% uninformative frames). The shipped instance uses the headless
renderer because it is faster and fully deterministic; the authentic path is available when visual
fidelity matters more than render cost, and `tools/p1_minecraft/AUTHENTIC_RENDER_ROUTES.md` records
the five blockers it took to get there. Because the ledger comes from the bot either way, the two
renderers are interchangeable without touching the ground truth.

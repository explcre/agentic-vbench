# [Task Proposal] Minecraft first-person gameplay action-ledger reconstruction

**Family:** `agentic_vbench_understanding` · **Proposed task id:** `minecraft-gameplay-ledger-s1`

> **Updated after review.**
> 1. **Matching rule stated in the task.** Events are aligned by an **order-preserving longest-common-subsequence** on the `(action, target)` tokens — gap-tolerant, so one missed/extra/wrong event costs only *that* event and the rest still match — and there is **no time tolerance and no timestamp matching**, only relative order.
> 2. **Palette nameability confirmed.** Block/mob **textures are stock Minecraft** for exactly the closed vocabulary; re-rolled palettes vary only *which* named blocks appear, never how a block looks, so every on-screen block/mob maps to one vocabulary entry with no legend lookup. Stated in the instruction.
> 3. **Calibration per the README.** Codex `gpt-5.6-sol` (xhigh) = **0.164** on this instance (honest medium, recall-limited; the automated structure/oracle/baseline/rollout checks pass, only the strong-agent gate is above 0.10). Raw trajectories in `calibration/rollouts/`; table below.
> 
> The graded video was also **re-rendered occlusion-safe**: every mined/placed block is brought into clear line of sight before the action (the generator raycasts to the target and repositions the camera, skipping any block it cannot show unoccluded), verified by viewing forest-gather, cabin-build and staircase-mine frames.

Branch **`pengchx-minecraft-gameplay-ledger`** (branched off `main`, this task only, for a focused review): <https://github.com/explcre/agentic-vbench/tree/pengchx-minecraft-gameplay-ledger>. The generator is bundled in the task dir as `generator/`.

## Is it hard enough / long-horizon?
A **53-minute first-person** Minecraft session: the player crosses all eight biomes (three passes,
re-rolled block palettes each pass), gathers many block types, builds three structures on camera (a
peaked-roof cottage, a village well, a watchtower), fights animals with **both a sword and a bow**,
takes a boat, and digs a staircase mine through layered rock for every ore. That is **628 deliberate
actions over 43 distinct block and mob types**. Reconstructing the *ordered* ledger means watching
the whole video, naming each block/mob from its rendered texture, telling apart the weapon used for
each kill, and getting the order right. A single frame, one modality, or a schema guess cannot
recover it. Real-world analog: analysing gameplay/instructional footage and verifying an embodied
agent's behaviour.

The same generator also emits a **19-minute / 248-event** instance (`game_v30.mp4`) and scales to
any length in between or beyond — see *Programmatic large-scale generation*.

## Cognitive level
**understanding** — track object identity (block type / mob type), action type, and the weapon used,
and order 628 events across 53 minutes. Not a lookup.

## Modalities required
- **video** — required; the ledger exists only across frames (a block breaking, the camera turning
  to it, a mob being struck).
- **audio** — deliberately none. Minecraft's break sounds are material-specific and its hurt sounds
  species-specific, so audio would hand over the very block and mob identities the task asks for.

## Question & output schema
> Reconstruct, in chronological order, every block **mined**, every block **placed**, and every mob
> **killed** — with the **weapon** used for each kill.
```json
{ "events": [ {"action": "mine"|"place"|"kill", "target": "<block or mob>", "tool": "sword"|"bow"} ] }
```
`target` ∈ a **closed vocabulary** (logs, leaves, terrain, ores, building materials; mobs: cow, pig,
sheep, chicken, wolf, mooshroom, polar_bear, turtle, panda). `tool` is required on kills. **Order**
is scored, not timestamps.

## Evidence chain
- Events are spread across the entire 53-minute session; identity needs the rendered texture (there
  are no labels), and order needs following the first-person view across the whole video.
- Far-apart moments are required by construction: the mine at the end exposes ores never seen
  earlier, and the three build passes re-roll palettes so no early segment predicts a later one.

## Ground truth
- **source:** the bot's own engine action events (mineflayer `diggingCompleted` / entity-death) and
  its own `/setblock` placements — the exact executed sequence, no annotation.
- **tier:** machine-truth.
- **verification:** oracle `solution.json` = the engine's action log; the shipped `judge.py` scores
  it **1.0** through the harness path. Video and ledger come from one seeded session, so they cannot
  drift. A build-time assertion refuses to ship a task whose ledger contains a target outside the
  closed vocabulary.

## Scorer (deterministic)
`reward = 0.85 · F2(action, target) + 0.15 · weapon-score(LCS-aligned kills)`, order-aware.

- The ledger term is an **order-aware, recall-weighted F2** over the `(action, target)` sequence (a
  longest-common-subsequence match, recall weighted **2× precision**). Recall is weighted because the
  task is to reconstruct *most* of the ledger — a small, confident subset is most of the task left
  undone.
- The weapon term is credited **only on kills that fall inside the ledger's LCS alignment** — the
  weapon of a kill you never identified is meaningless. (Scored independently it was nearly free:
  two weapon classes let an all-"stone" answer reach weapon 1.0 on a 0.03 ledger.)

Measured on the shipped ground truth: **oracle 1.0** (harness path), correct-multiset-but-shuffled
**0.224**, most-common-token-repeated **0.081**, actions-right-every-target-wrong **0.027**, empty
**0.0**.

## Difficulty (calibration in progress)
| harness | reward | tool-calls | notes |
|---|---|---|---|
| **Codex `gpt-5.6-sol` (xhigh)** | **0.164** | 241 | fresh run under the F2 instruction on the 53-min video |
| Antigravity (Gemini-3.x) | *to run* | | |
| Claude Code (Opus 4.8 / Fable 5) | *to run* | | |

**Honest standing: 0.164 — close to the family's <0.10 bar but not under it**, stated here rather
than massaged (the automated `check_task.py` structure/oracle/baseline/rollout checks all PASS; only
the strong-agent gate is above 0.10). The difficulty is
**recall-limited** — Codex has 0.79 precision (it names what it looks at well) but 0.13 recall (it
does not watch the whole 53-min video). Order-aware LCS is deliberately generous to a confident
partial answer, so a strong agent that correctly reconstructs ~13% in order scores ~0.16. Two data
points show length lowers it (v30 19-min ≈ 0.29 under the old F1 scorer → v31 53-min = 0.164), but
the agent compensates for longer video by working harder, so reaching <0.10 would need ~150-200 min
— within the family's 10-300 min window but a large render. Making it genuinely harder without more
length is still open (denser events per minute, or a second scored dimension). `calibration/scores.md`
carries the full length-vs-difficulty analysis; raw trajectories per harness are in
`calibration/rollouts/`.

## Anti-shortcut ablations (all ≤ 0.15 except the order-sensitivity row, which is not a shortcut)
- **single_frame** — **0.0**. Codex given one representative frame wrote an empty ledger on its own
  reasoning that one frame yields no ordered sequence.
- **no_media** — the event distribution is not knowable blind: most-common-token **0.081**,
  wrong-targets **0.027**.
- **frame_dump_no_tools** — **0.0** in practice: a 53-min video at 1 fps is >3000 frames, far past
  any context window, so an agent cannot ingest it without seeking tools.
- **shuffled** — **0.224**. Build palettes alternate *within* each layer and the mine cuts layered
  strata, so there is no long run of one block for a "plausible build" guess to match. This is order
  sensitivity, not a shortcut: reproducing the exact 628-event multiset means watching the whole
  video.
- The HUD shows hearts/hunger/XP and the selected hotbar slot, but **no action log and no block or
  mob labels**, so it never states an answer; the held-weapon indicator is the intended evidence for
  the `tool` field.

## Input media
- **url:** `https://huggingface.co/datasets/explcre/agenticvbench-understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/game_v32.mp4`
  (self-rendered, self-hosted; not scraped → no famous-footage leakage).
- **sha256:** `406d447d43b9b9ebadb2ebe5b9cb54cf4e7b7f48c3874bf6a6b9c045260512b2`, pinned in
  `environment/Dockerfile` and verified against the downloaded bytes (not just the upload's exit
  status).
- **length:** 53.3 min. **resolution:** 1280×720. **audio:** none (see Modalities).

## Programmatic large-scale generation ⭐
This is a **generator**, not a single clip. `generator/bot_play8.js` plays a parameterised
session on a seeded world — biomes visited, structures built, mob roster, tool use, and **number of
laps** (`P1_LAPS`) are all knobs — and render → ground truth is one command with **zero annotation**.
The two shipped instances are the same program at different settings:

| instance | laps | length | events | how it was produced |
|---|---|---|---|---|
| `game_v30.mp4` | 1 | 19 min | 248 | `P1_LAPS=1` |
| `game_v31_long.mp4` (graded) | 3 | 53 min | 628 | `P1_LAPS=3` |

The space of distinct, machine-labeled sessions is effectively unlimited (seed × biome route × build
set × mob mix × laps), so the benchmark can **mint an arbitrary number of fresh instances at any
target length/difficulty, hold out unseen combinations, and re-generate if a clip ever leaks** — the
anti-overfitting property the paper wants. Every scored event is machine-truth straight from the
engine, so scale costs no labelling.

## Why it's novel (paper context)
Freshly rendered (zero dataset overlap). Distinct from VPT/MineRL frame-level inverse dynamics:
long-horizon, high-level, *ordered* event-ledger reconstruction with a deterministic verifier — the
AgenticVBench thesis, not behaviour cloning.

## Fairness constraints enforced during generation
Each was found by inspecting frames, and each would otherwise have put **unanswerable rows** in the
ground truth:
1. **Only mobs the renderer actually draws are in the vocabulary.** An audit of 27 mobs found 11
   render in the headless renderer; zombies, creepers, villagers, foxes, rabbits, horses and llamas
   draw as *nothing* even though the entity exists and the camera tracks it. Earlier drafts scored
   kills on invisible mobs.
2. **Every scored kill and placement is witnessed.** A kill counts only if the mob was in range with
   the camera on it for several consecutive attack ticks; a block counts only if it was in the view
   cone *and* in clear line of sight (not behind an already-built wall), and the player steps around
   to a block's own face before placing it.
3. **Nothing exists in the finished build that is absent from the ledger.** The converse of (2):
   blocks the camera missed used to be `/setblock` into the world anyway, so a finished cabin held
   ~33% of blocks (median 86° off-axis) that were *not* in the ground truth, penalising an agent
   listing what it watched. They are now **deferred** and placed for real on camera in a second pass
   (residual 0 on the shipped build).
4. **Every structure is verified visible.** The generator raycasts to each finished build and checks
   the first solid block hit belongs to it, logging `ORBIT_SHOWN n/m` (cabin 6/6, watchtower and well
   5/5). Build sites must be flat and tree-free — no log or leaf in the footprint, ≥85% of columns
   within one block, spread ≤3 — or walls end up half-buried or screened by canopy.
5. **The closed vocabulary is asserted against the ledger at build time.** The staircase mine records
   the real blocks it digs, so the vocabulary must cover the terrain of every biome on the route. The
   builder refuses to emit a task whose ground truth contains an unlisted target — it caught
   `brown_terracotta` in badlands on a real session.
6. **The tail is trimmed to the captured window.** The capture can end a few seconds before the bot's
   final events; those events are dropped from the ground truth so the ledger never contains an action
   the video does not show.

## Reproducibility
Regenerable from a seed: `generator/` (Paper 1.16.5 + mineflayer-pathfinder bot
`bot_play8.js` + prismarine-viewer first-person + ffmpeg). No manual annotation. The HUD, the vanilla
block-break crack and the hit-flash are composited from the *real* game assets at the bot's own event
times, because the headless renderer draws none of them. `finish_session.sh` runs the whole
composite → ground-truth → ablation chain in one step with per-stage assertions.

## Renderer: headless first-person (the graded video)
The graded video is the **headless first-person** render (prismarine-viewer): the camera *is* the
bot, so what the bot does is exactly what the frame shows, deterministically and verifiably. Every
action is framed by construction — verified frame-by-frame, not just by metric (house build with the
authentic HUD, mob strikes, ore extraction). The HUD, the vanilla block-break crack and the
hit-flash are composited from the *real* game assets at the bot's own event times, because the
headless renderer draws none of them.

An **authentic real-client route** (real Minecraft 1.20.4, camera slaved to the bot with `/spectate`)
was prototyped for higher visual fidelity, but its camera does **not** reliably follow a bot that
teleports across the world — `/spectate` fixes the camera at the bot's initial position and does not
track subsequent moves in this headless offline setup, so the recording freezes on the spawn view. It
is therefore **not** part of the shipped task; `generator/AUTHENTIC_RENDER_ROUTES.md` records
the attempts and the open camera-follow problem. The headless renderer is the deliverable precisely
because its camera cannot desync from the bot.

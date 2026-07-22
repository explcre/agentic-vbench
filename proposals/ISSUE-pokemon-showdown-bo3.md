# [Task Proposal] Pokémon Showdown best-of-3 move-ledger reconstruction

**Family:** `agentic_vbench_understanding` · **task id:** `pokemon-showdown-bo3-move-ledger-s7`

## Hard / long-horizon?
A 10:39 video of a best-of-three Gen-9 random-battle series (official replay engine),
with the **move-name text bar removed**. Reconstructing every move each side used, per
turn, across 3 games = **388 move events**, requires inferring each move from its
animation + HP-bar change + status effects (matched to the revealed movesets), across
the whole video. Single frame / one modality / schema guess all fail; 50+ tool calls.

## Cognitive level: reasoning
Move identity is not shown; it must be inferred (animation + HP delta + effect) and
matched to the acting Pokémon's 4-move set — cross-signal inference, not a lookup.

## Modalities: video required (animation + HP bars); audio unused.

## Question → schema
> For every turn of every game, which move did each side use?
```json
{ "moves": [ {"game": 1-3, "turn": int, "side": "Red"|"Blue", "move": "<name from vocab>"} ] }
```
Closed vocabulary = each game's two teams' movesets (revealed in the prompt). turn tolerance ±1.

## Ground truth
- **source:** pokemon-showdown 0.11.10 simulator move log (seed 7). **tier:** machine-truth.
- **verification:** oracle solution.json = the sim's move log → scorer 1.0 (388/388).
  Video + ledger both derive from one seeded series → cannot drift.

## Scorer (deterministic)
F1 over moves; TP iff same game, side, normalised move name, and turn within 1. Each GT
move matches ≤1 prediction. oracle=1.0, empty=0.0 (verified).

## Anti-shortcut (≤0.15)
- **ocr_text** — the `.messagebar` move-name layer is hidden at render time (verified on frames).
- **no_media** — random play order not derivable from the revealed teams.
- **single_frame** — no move sequence in one frame.

## Input media: self-hosted HF mp4, SHA-pinned, 10:39, 720p (official replay engine, log panel hidden).

## Difficulty: calibrate Codex/Antigravity/Claude to <0.10 over 50+ turns.

## Novel / reproducible
Fresh-rendered; distinct from move-prediction datasets. Regenerable from seed:
`tools/p2_pokemon/` (sim → log=GT → replay HTML with text hidden → Playwright capture → Bo3 concat).

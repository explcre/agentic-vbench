# Pokémon Battle-Set Structural-Ledger Reconstruction

You are given one silent video at `/workspace/materials/game.mp4`: a set of **5 Pokémon
battles** (Generation 9 singles) played one after another. Each battle is introduced by
a full-screen title card reading `BATTLE 1` … `BATTLE 5`. The two sides are always
`p1` (left, bottom of the field) and `p2` (right, top of the field). The current turn
number is shown on screen.

Across all five battles, reconstruct the ledger of two kinds of structural events:

- **switch_in**: a Pokémon becomes the active Pokémon on a side — the lead at the start
  of a battle, a voluntary switch, or a replacement after a faint.
- **faint**: an active Pokémon faints (its HP reaches zero and it leaves the field).

Identify each Pokémon by its **species name** (English, e.g. `Necrozma`, `Arboliva`).
Use any tools in the image (for example `ffmpeg` and `ffprobe`) to seek and sample the
video. Your evidence is the battle scene itself: the sprites, the HP bars, the turn
counter, and the title cards. Do not report the moves used — report only switch-ins and
faints.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape:

```json
{
  "events": [
    {"game": 1, "turn": 0, "side": "p1", "event": "switch_in", "species": "Grumpig"},
    {"game": 1, "turn": 3, "side": "p2", "event": "faint",     "species": "Eelektross"}
  ]
}
```

- `game`: 1 to 5, the battle number shown on the title card.
- `turn`: the on-screen turn number when the event happens (`0` for the opening leads,
  before turn 1).
- `side`: `p1` or `p2`.
- `event`: `switch_in` or `faint`.
- `species`: the English species name of the Pokémon involved.

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online, and do not rely on memory; find every event in the video.
- Report only `switch_in` and `faint` events. Do not report moves, items, or status.

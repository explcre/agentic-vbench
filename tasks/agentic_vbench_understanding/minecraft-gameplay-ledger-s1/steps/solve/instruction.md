# Minecraft First-Person Gameplay Ledger Reconstruction

You are given one video at `/workspace/materials/game.mp4`: a ~10-minute **first-person**
recording of a player exploring a Minecraft world. The player walks around purposefully,
**mines** blocks (chopping trees, digging resources — the view turns to face each block
as it breaks), and **kills** animals it hunts.

Reconstruct the player's deliberate action ledger **in the order the actions happen**:

- **mine** — the player breaks a block; report the block type.
- **kill** — the player kills a mob; report the mob type.

Identify block and mob types from their rendered textures. Use any tools in the image
(for example `ffmpeg` and `ffprobe`) to seek through and sample the video. There is no
HUD or text overlay — your only evidence is the rendered first-person view.

## What to submit

Write `/workspace/output/solution.json`, actions in chronological order:

```json
{
  "events": [
    {"action": "mine", "target": "oak_log"},
    {"action": "mine", "target": "oak_leaves"},
    {"action": "kill", "target": "chicken"}
  ]
}
```

- `action`: `mine` or `kill`.
- `target`: a block type (for `mine`) or a mob type (for `kill`) from the vocab below.

## Vocabulary (closed)

Blocks: `oak_log`, `birch_log`, `spruce_log`, `oak_leaves`, `birch_leaves`, `grass_block`, `dirt`, `stone`, `cobblestone`, `gravel`, `sand`.
Mobs: `cow`, `pig`, `sheep`, `chicken`, `rabbit`, `mooshroom`, `wolf`, `ocelot`, `fox`, `llama`.

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. Reconstruct the actions from the video, in order.
- Report only `mine` and `kill` actions (not walking, looking, or item pickups).

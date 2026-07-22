# Minecraft First-Person Gameplay Ledger Reconstruction

You are given one video at `/workspace/materials/game.mp4`: a ~10-minute **first-person**
recording of a player exploring a Minecraft world. The player walks and looks around,
**mines** blocks (the view turns to face each block as it breaks), and **fights** a mob.

Reconstruct the player's deliberate action ledger **in the order the actions happen**.
Report two kinds of action:

- **mine** — the player breaks a block; report the block type.
- **kill** — the player defeats a mob; report the mob type.

Identify block and mob types from their rendered textures. Use any tools in the image
(for example `ffmpeg` and `ffprobe`) to seek through and sample the video. There is no
HUD or text overlay — your only evidence is the rendered first-person view.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape, with actions in
chronological order (earliest first):

```json
{
  "events": [
    {"action": "mine", "target": "oak_log"},
    {"action": "mine", "target": "dirt"},
    {"action": "kill", "target": "pig"}
  ]
}
```

- `action`: `mine` or `kill`.
- `target`: for `mine`, one of the block types below; for `kill`, the mob type.

## Block vocabulary (closed)

Blocks mined in this video are among:

- birch_log
- dirt
- grass_block
- oak_leaves
- oak_log
- stone

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. Reconstruct the actions from the video, in order.
- Report only `mine` and `kill` actions (not walking, looking, or item pickups).

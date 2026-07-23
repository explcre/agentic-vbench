# Minecraft First-Person Gameplay Ledger Reconstruction

You are given one video at `/workspace/materials/game.mp4`: a ~10-minute **first-person**
recording of a player traveling across several Minecraft biomes (forest, desert, snowy mountains, badlands). The player explores and mines many block
types (including ores), hunts a variety of animals, and **builds a small house**
block-by-block; the world transitions from day to night.

Reconstruct the player's deliberate action ledger **in the order the actions happen**:

- **mine** — the player breaks a block; report the block type.
- **place** — the player places a block (while building); report the block type.
- **kill** — the player kills a mob; report the mob type.

Identify block/mob types from their rendered textures. Use any tools in the image (for
example `ffmpeg` and `ffprobe`) to seek through and sample the video. There is no HUD or
text overlay — your only evidence is the rendered first-person view.

## What to submit

Write `/workspace/output/solution.json`, actions in chronological order:

```json
{
  "events": [
    {"action": "mine",  "target": "oak_log"},
    {"action": "mine",  "target": "iron_ore"},
    {"action": "place", "target": "oak_planks"},
    {"action": "kill",  "target": "cow"}
  ]
}
```

- `action`: `mine`, `place`, or `kill`.
- `target`: a block type (mine/place) or a mob type (kill), from the vocab below.

## Vocabulary (closed)

Blocks (mine/place): `oak_log`, `birch_log`, `spruce_log`, `oak_leaves`, `birch_leaves`,
`spruce_leaves`, `grass_block`, `dirt`, `gravel`, `stone`, `cobblestone`, `sand`,
`sandstone`, `cactus`, `dead_bush`, `snow_block`, `ice`, `packed_ice`, `red_sand`,
`red_sandstone`, `terracotta`, `orange_terracotta`, `coal_ore`, `iron_ore`, `gold_ore`,
`redstone_ore`, `diamond_ore`, `lapis_ore`, `emerald_ore`, `oak_planks`, `spruce_planks`,
`glass`, `oak_door`, `torch`.
Mobs (kill): `cow`, `pig`, `sheep`, `chicken`, `rabbit`, `mooshroom`, `wolf`, `ocelot`,
`fox`, `llama`, `zombie`, `skeleton`, `spider`, `creeper`.

## Rules
- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. Reconstruct the actions from the video, in order.
- Report only `mine`, `place`, and `kill` actions (not walking, looking, or pickups).

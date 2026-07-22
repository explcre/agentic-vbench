# Minecraft Build/Mine Session Ledger Reconstruction

You are given one silent video at `/workspace/materials/game.mp4`: a recording of a
Minecraft world (fixed third-person camera) in which a builder lays out a flat mosaic
of coloured blocks on the ground and then mines several of them away. Over the session,
individual blocks are **placed** (a block appears on the ground) and **broken** (a
placed block disappears back to grass), one event at a time.

Reconstruct the complete ledger of block events **in the order they happen**. For each
event, report whether a block was placed or broken and the block type. Identify the
block type by its rendered texture/colour, from the closed list below.

Use any tools in the image (for example `ffmpeg` and `ffprobe`) to seek through and
sample the video. There is no HUD, chat, or coordinate display — your only evidence is
the rendered world.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape, with the events in
chronological order (earliest first):

```json
{
  "events": [
    {"action": "place", "block": "stone"},
    {"action": "place", "block": "oak_planks"},
    {"action": "break", "block": "bricks"}
  ]
}
```

- List events in the order they occur in the video.
- `action`: `place` (a block appears) or `break` (a placed block disappears).
- `block`: the block type, exactly one of the closed vocabulary below.

## Block vocabulary (closed)

Every block in the video is one of these; report the exact name:

- bricks
- cobblestone
- diamond_block
- emerald_block
- gold_block
- lapis_block
- netherrack
- oak_planks
- redstone_block
- sand
- stone

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. The build order is not predictable; find every event
  in the video, in order.
- Report only block place/break events. Do not report bot movement or anything else.

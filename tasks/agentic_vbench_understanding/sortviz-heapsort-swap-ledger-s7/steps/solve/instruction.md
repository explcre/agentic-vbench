# Sorting-Visualization Swap-Ledger Reconstruction

You are given one silent video at `/workspace/materials/game.mp4`: an animation of a
row of vertical bars being sorted. There are **80 bars**, all the same colour, each a
**distinct height**. The bars start in a shuffled order and, by the end, stand in
increasing height from left to right.

The only thing that ever happens in the video is a **swap**: two bars exchange their
left-to-right positions, animated as the two bars sliding past each other. Swaps
happen one at a time. Reconstruct the complete, ordered ledger of every swap.

Identify each bar by its **height rank**: `1` is the shortest bar in the video, `2`
the next shortest, and so on up to `80`, the tallest. For every swap, report the pair
of ranks of the two bars that exchanged places, and the approximate time in the video
when the swap happens. Use any tools in the image (for example `ffmpeg` and
`ffprobe`) to seek through and sample the video.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape:

```json
{
  "swaps": [
    {"t": "00:07", "bars": [12, 47]},
    {"t": "00:11", "bars": [3, 5]}
  ]
}
```

- One entry per swap.
- `t`: the time the swap happens, measured from the start of the video, as `mm:ss`
  (seconds alone, e.g. `7` or `7.5`, are also accepted).
- `bars`: the two height ranks that exchanged places, as a two-element list. Order
  within the pair does not matter (`[12, 47]` and `[47, 12]` are the same swap). Ranks
  are `1` (shortest bar) to `80` (tallest bar).

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. The swap order is not any textbook algorithm you
  can guess from the starting arrangement; find every swap in the video.
- Report only actual position swaps. There are no other events to report.

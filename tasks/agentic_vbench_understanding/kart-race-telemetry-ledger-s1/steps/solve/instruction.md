# Kart Race Telemetry Reconstruction

You are given one video at `/workspace/materials/race.mp4`: a suite of **four AI-driven
SuperTuxKart races**, one after another, each on a different track with six karts. A race
change is obvious — the scene cuts to a new track and a new starting grid.

For each race, work out **the order the karts finished in**, and **how many powerup boxes
each kart collected** during that race.

Evidence is on screen throughout:

- The **ranking column** (top left) lists the karts by current position, by character icon.
- The **minimap** (bottom left) shows every kart as a marker, so you can follow who is where
  even when a kart is off camera.
- Karts are visually distinct characters; the same character keeps its colours all race.
- A kart collects a powerup by driving through a **question-mark box**; the powerup then
  appears in that kart's slot.

## What to submit

Write `/workspace/output/solution.json`, races in the order they appear in the video:

```json
{
  "races": [
    {
      "track": "hacienda",
      "karts": [
        {"kart": "tux",    "finish_position": 2, "items_collected": 10},
        {"kart": "amanda", "finish_position": 1, "items_collected": 17}
      ]
    }
  ]
}
```

- `kart`: the character name as shown in game (for example `tux`, `gnu`, `konqi`, `nolok`,
  `amanda`, `beastie`, `kiki`, `adiumy`, `pidgin`, `puffy`, `hexley`, `wilber`, `xue`,
  `emule`, `gavroche`, `suzanne`, `sara_the_racer`, `sara_the_wizard`).
- `finish_position`: 1 for the winner, up to 6.
- `items_collected`: how many powerup boxes that kart drove through in that race.
- `track` is optional and not scored.

## How it is scored

Both parts are scored as **rank agreement** (normalised Kendall correlation), not exact
match:

    reward = 0.70 * agreement(finish order) + 0.30 * agreement(items-collected order)

Getting the order partly right earns partial credit — the podium alone is worth real score.
Guessing earns nothing: a random ordering scores 0 in expectation, because agreeing and
disagreeing pairs cancel out.

## Rules
- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. Reconstruct the results from the video.
- Report all four races, in the order they appear.

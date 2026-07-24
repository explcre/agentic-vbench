# Kart Race Telemetry Reconstruction

You are given one video at `/workspace/materials/race.mp4`: a suite of **four AI-driven
SuperTuxKart races**, one after another, each on a different track with six karts. A race
change is obvious — the scene cuts to a new track and a new starting grid.

For each race, reconstruct, per kart:
- **which grid slot it started in** (read the starting line before the race begins),
- **the order it finished in**,
- **how many powerup boxes it collected**, and
- **how much nitro it picked up** (the small and large nitro cans along the track).

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
        {"kart": "tux",    "start_position": 1, "finish_position": 2, "items_collected": 10, "nitro_collected": 12},
        {"kart": "amanda", "start_position": 4, "finish_position": 1, "items_collected": 17, "nitro_collected": 11}
      ]
    }
  ]
}
```

- `kart`: the character name as shown in game (for example `tux`, `gnu`, `konqi`, `nolok`,
  `amanda`, `beastie`, `kiki`, `adiumy`, `pidgin`, `puffy`, `hexley`, `wilber`, `xue`,
  `emule`, `gavroche`, `suzanne`, `sara_the_racer`, `sara_the_wizard`).
- `start_position`: grid slot, 1 for pole, up to 6.
- `finish_position`: 1 for the winner, up to 6.
- `items_collected`: how many powerup boxes that kart drove through in that race.
- `nitro_collected`: how many nitro cans that kart picked up.
- `track` is optional and not scored.

## How it is scored

Every field is scored as **rank agreement** (normalised Kendall correlation), not exact match:

    reward =  0.45 * agreement(finish order)
            + 0.15 * agreement(start-grid order)
            + 0.25 * agreement(items-collected order)
            + 0.15 * agreement(nitro-collected order)

Getting an order partly right earns partial credit — the podium alone is worth real score.
Guessing earns nothing: a random ordering scores 0 in expectation, because agreeing and
disagreeing pairs cancel out. You do not have to count pickups exactly; ranking the karts by
how many they collected is what matters.

## Rules
- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. Reconstruct the results from the video.
- Report all four races, in the order they appear.

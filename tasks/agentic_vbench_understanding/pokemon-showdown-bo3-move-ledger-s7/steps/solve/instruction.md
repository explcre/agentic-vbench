# Pokémon Showdown Best-of-3 Move-Ledger Reconstruction

You are given one video at `/workspace/materials/game.mp4`: a best-of-three
Pokémon (Generation 9 Random Battle) series between two players, **Red** and **Blue**.
A title card (`GAME 1`, `GAME 2`, `GAME 3`) precedes each game, and the on-screen
turn counter shows the current turn within that game.

Reconstruct, for every turn of every game, the move each side used. The move-name
text is **not** shown in the video: you must infer each move from its animation, the
resulting HP change, and any status/stat effects, choosing from the known movesets
listed below. Use any tools in the image (for example `ffmpeg` and `ffprobe`) to seek
through and sample the video.

Note: a side does not always use a move on a given turn (it may switch Pokémon, or be
unable to act). Report only turns where a side actually **used a move**.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape:

```json
{
  "moves": [
    {"game": 1, "turn": 1, "side": "Red",  "move": "Stealth Rock"},
    {"game": 1, "turn": 1, "side": "Blue", "move": "Triple Arrows"}
  ]
}
```

- One entry per move used.
- `game`: 1, 2, or 3.
- `turn`: the turn number shown on screen when the move was used.
- `side`: `Red` or `Blue`.
- `move`: the move's name, exactly as written in the movesets below.

## Known movesets (closed vocabulary)

Each Pokémon uses only the four moves listed for it. Every move you report must be one
of these.

### Game 1
**Red's team:**
- Mimikyu: Shadow Claw, Play Rough, Swords Dance, Shadow Sneak
- Hippowdon: Slack Off, Stone Edge, Stealth Rock, Earthquake
- Mismagius: Thunderbolt, Dazzling Gleam, Shadow Ball, Nasty Plot
- Mudsdale: Earthquake, Stone Edge, Roar, Heavy Slam
- Brute Bonnet: Crunch, Spore, Sucker Punch, Seed Bomb
- Palkia: Hydro Pump, Draco Meteor, Fire Blast, Thunder Wave

**Blue's team:**
- Salazzle: Fire Blast, Sludge Wave, Nasty Plot, Tera Blast
- Reuniclus: Shadow Ball, Psychic, Calm Mind, Recover
- Decidueye-Hisui: Leaf Blade, Knock Off, Triple Arrows, Roost
- Falinks: Knock Off, No Retreat, Iron Head, Close Combat
- Polteageist-Antique: Stored Power, Shell Smash, Shadow Ball, Giga Drain
- Scyther: Dual Wingbeat, Close Combat, Bug Bite, Swords Dance

### Game 2
**Red's team:**
- Luxray: Volt Switch, Ice Fang, Throat Chop, Wild Charge
- Altaria: Brave Bird, Defog, Roost, Will-O-Wisp
- Terapagos-Terastal: Rest, Calm Mind, Earth Power, Tera Starstorm
- Cinderace: Court Change, High Jump Kick, U-turn, Pyro Ball
- Venomoth: Bug Buzz, Sleep Powder, Quiver Dance, Sludge Wave
- Furret: Brick Break, Knock Off, Tidy Up, Double-Edge

**Blue's team:**
- Ursaluna: Crunch, Headlong Rush, Facade, Trailblaze
- Greedent: Swords Dance, Knock Off, Double-Edge, Earthquake
- Volbeat: Encore, Lunge, Roost, Thunder Wave
- Mewtwo: Psystrike, Recover, Fire Blast, Nasty Plot
- Scyther: Swords Dance, Dual Wingbeat, Close Combat, Bug Bite
- Lunala: Moonlight, Moonblast, Moongeist Beam, Calm Mind

### Game 3
**Red's team:**
- Jirachi: Iron Head, Wish, Protect, U-turn
- Raikou: Thunderbolt, Substitute, Calm Mind, Scald
- Venomoth: Sleep Powder, Quiver Dance, Bug Buzz, Sludge Wave
- Slowking: Thunder Wave, Slack Off, Scald, Psychic Noise
- Milotic: Flip Turn, Recover, Scald, Ice Beam
- Smeargle: Ceaseless Edge, Sticky Web, Spore, Whirlwind

**Blue's team:**
- Magnezone: Body Press, Thunderbolt, Flash Cannon, Volt Switch
- Articuno: Substitute, Roost, Freeze-Dry, Brave Bird
- Cresselia: Moonblast, Psyshock, Moonlight, Calm Mind
- Porygon-Z: Thunderbolt, Ice Beam, Shadow Ball, Tri Attack
- Bruxish: Aqua Jet, Ice Fang, Psychic Fangs, Wave Crash
- Ariados: Toxic Spikes, Megahorn, Poison Jab, Sticky Web

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. The order of moves is not predictable from the
  teams; find each move in the video.
- Report only moves that were actually used, matched to the movesets above.

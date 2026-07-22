#!/bin/bash
# Oracle: write the verified move ledger. Auto-generated from the same series
# seed as the video, so it is the answer key, not an echo. Agent never sees it.
set -euo pipefail
mkdir -p /workspace/output
cat > /workspace/output/solution.json <<'ORACLE_JSON'
{
  "moves": [
    {
      "game": 1,
      "turn": 1,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 1,
      "side": "Red",
      "move": "Stealth Rock"
    },
    {
      "game": 1,
      "turn": 2,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 3,
      "side": "Blue",
      "move": "Leaf Blade"
    },
    {
      "game": 1,
      "turn": 4,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 4,
      "side": "Red",
      "move": "Heavy Slam"
    },
    {
      "game": 1,
      "turn": 5,
      "side": "Blue",
      "move": "Knock Off"
    },
    {
      "game": 1,
      "turn": 5,
      "side": "Red",
      "move": "Earthquake"
    },
    {
      "game": 1,
      "turn": 6,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 7,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 1,
      "turn": 7,
      "side": "Red",
      "move": "Roar"
    },
    {
      "game": 1,
      "turn": 8,
      "side": "Blue",
      "move": "Bug Bite"
    },
    {
      "game": 1,
      "turn": 9,
      "side": "Blue",
      "move": "Close Combat"
    },
    {
      "game": 1,
      "turn": 9,
      "side": "Red",
      "move": "Thunder Wave"
    },
    {
      "game": 1,
      "turn": 10,
      "side": "Red",
      "move": "Fire Blast"
    },
    {
      "game": 1,
      "turn": 11,
      "side": "Red",
      "move": "Thunder Wave"
    },
    {
      "game": 1,
      "turn": 11,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 12,
      "side": "Red",
      "move": "Fire Blast"
    },
    {
      "game": 1,
      "turn": 12,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 1,
      "turn": 13,
      "side": "Red",
      "move": "Thunder Wave"
    },
    {
      "game": 1,
      "turn": 13,
      "side": "Blue",
      "move": "Triple Arrows"
    },
    {
      "game": 1,
      "turn": 14,
      "side": "Red",
      "move": "Nasty Plot"
    },
    {
      "game": 1,
      "turn": 14,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 1,
      "turn": 15,
      "side": "Red",
      "move": "Nasty Plot"
    },
    {
      "game": 1,
      "turn": 15,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 1,
      "turn": 16,
      "side": "Red",
      "move": "Dazzling Gleam"
    },
    {
      "game": 1,
      "turn": 17,
      "side": "Red",
      "move": "Nasty Plot"
    },
    {
      "game": 1,
      "turn": 17,
      "side": "Blue",
      "move": "Shadow Ball"
    },
    {
      "game": 1,
      "turn": 18,
      "side": "Red",
      "move": "Thunderbolt"
    },
    {
      "game": 1,
      "turn": 19,
      "side": "Red",
      "move": "Nasty Plot"
    },
    {
      "game": 1,
      "turn": 19,
      "side": "Blue",
      "move": "Close Combat"
    },
    {
      "game": 1,
      "turn": 20,
      "side": "Red",
      "move": "Dazzling Gleam"
    },
    {
      "game": 1,
      "turn": 21,
      "side": "Blue",
      "move": "Tera Blast"
    },
    {
      "game": 1,
      "turn": 21,
      "side": "Red",
      "move": "Seed Bomb"
    },
    {
      "game": 1,
      "turn": 22,
      "side": "Blue",
      "move": "Tera Blast"
    },
    {
      "game": 1,
      "turn": 22,
      "side": "Red",
      "move": "Seed Bomb"
    },
    {
      "game": 1,
      "turn": 23,
      "side": "Blue",
      "move": "Tera Blast"
    },
    {
      "game": 1,
      "turn": 23,
      "side": "Red",
      "move": "Seed Bomb"
    },
    {
      "game": 1,
      "turn": 24,
      "side": "Red",
      "move": "Sucker Punch"
    },
    {
      "game": 1,
      "turn": 24,
      "side": "Blue",
      "move": "Nasty Plot"
    },
    {
      "game": 1,
      "turn": 25,
      "side": "Blue",
      "move": "Fire Blast"
    },
    {
      "game": 1,
      "turn": 26,
      "side": "Blue",
      "move": "Fire Blast"
    },
    {
      "game": 1,
      "turn": 26,
      "side": "Red",
      "move": "Shadow Claw"
    },
    {
      "game": 1,
      "turn": 27,
      "side": "Blue",
      "move": "Fire Blast"
    },
    {
      "game": 2,
      "turn": 1,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 1,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 2,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 2,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 3,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 3,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 4,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 5,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 5,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 6,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 6,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 7,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 7,
      "side": "Red",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 8,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 9,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 9,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 10,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 10,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 11,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 11,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 12,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 13,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 13,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 14,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 14,
      "side": "Red",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 15,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 16,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 16,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 17,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 17,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 18,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 18,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 19,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 19,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 20,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 20,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 21,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 21,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 22,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 23,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 23,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 24,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 25,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 25,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 26,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 26,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 27,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 27,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 28,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 29,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 29,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 30,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 30,
      "side": "Red",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 31,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 31,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 32,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 32,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 33,
      "side": "Blue",
      "move": "Roost"
    },
    {
      "game": 2,
      "turn": 34,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 34,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 35,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 35,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 36,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 37,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 37,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 38,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 39,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 39,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 40,
      "side": "Blue",
      "move": "Encore"
    },
    {
      "game": 2,
      "turn": 41,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 41,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 42,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 43,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 43,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 44,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 45,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 45,
      "side": "Red",
      "move": "Defog"
    },
    {
      "game": 2,
      "turn": 46,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 47,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 48,
      "side": "Blue",
      "move": "Lunge"
    },
    {
      "game": 2,
      "turn": 49,
      "side": "Blue",
      "move": "Thunder Wave"
    },
    {
      "game": 2,
      "turn": 49,
      "side": "Red",
      "move": "Will-O-Wisp"
    },
    {
      "game": 2,
      "turn": 50,
      "side": "Blue",
      "move": "Psystrike"
    },
    {
      "game": 2,
      "turn": 51,
      "side": "Blue",
      "move": "Fire Blast"
    },
    {
      "game": 2,
      "turn": 51,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 2,
      "turn": 52,
      "side": "Red",
      "move": "Bug Buzz"
    },
    {
      "game": 2,
      "turn": 53,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 2,
      "turn": 53,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 54,
      "side": "Red",
      "move": "Sludge Wave"
    },
    {
      "game": 2,
      "turn": 54,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 55,
      "side": "Red",
      "move": "Bug Buzz"
    },
    {
      "game": 2,
      "turn": 55,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 56,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 56,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 57,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 57,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 58,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 58,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 59,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 59,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 60,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 60,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 61,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 61,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 62,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 62,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 63,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 63,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 64,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 64,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 65,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 66,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 67,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 67,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 68,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 68,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 69,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 69,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 70,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 70,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 71,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 71,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 72,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 73,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 74,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 74,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 75,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 75,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 76,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 76,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 77,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 78,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 79,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 79,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 80,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 2,
      "turn": 80,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 81,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 82,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 83,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 83,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 84,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 84,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 85,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 86,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 87,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 87,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 88,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 88,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 89,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 89,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 90,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 90,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 91,
      "side": "Blue",
      "move": "Moongeist Beam"
    },
    {
      "game": 2,
      "turn": 91,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 92,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 92,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 93,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 93,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 94,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 94,
      "side": "Red",
      "move": "Rest"
    },
    {
      "game": 2,
      "turn": 95,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 96,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 97,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 97,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 98,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 98,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 99,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 99,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 100,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 100,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 101,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 101,
      "side": "Red",
      "move": "Tera Starstorm"
    },
    {
      "game": 2,
      "turn": 102,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 102,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 103,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 103,
      "side": "Red",
      "move": "Earth Power"
    },
    {
      "game": 2,
      "turn": 104,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 105,
      "side": "Red",
      "move": "Court Change"
    },
    {
      "game": 2,
      "turn": 105,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 106,
      "side": "Red",
      "move": "Court Change"
    },
    {
      "game": 2,
      "turn": 106,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 107,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 107,
      "side": "Red",
      "move": "Volt Switch"
    },
    {
      "game": 2,
      "turn": 108,
      "side": "Red",
      "move": "Double-Edge"
    },
    {
      "game": 2,
      "turn": 108,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 109,
      "side": "Red",
      "move": "Double-Edge"
    },
    {
      "game": 2,
      "turn": 109,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 2,
      "turn": 110,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 110,
      "side": "Red",
      "move": "Volt Switch"
    },
    {
      "game": 2,
      "turn": 111,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 111,
      "side": "Red",
      "move": "Ice Fang"
    },
    {
      "game": 2,
      "turn": 112,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 2,
      "turn": 112,
      "side": "Red",
      "move": "Wild Charge"
    },
    {
      "game": 2,
      "turn": 113,
      "side": "Red",
      "move": "Wild Charge"
    },
    {
      "game": 2,
      "turn": 113,
      "side": "Blue",
      "move": "Trailblaze"
    },
    {
      "game": 2,
      "turn": 114,
      "side": "Blue",
      "move": "Headlong Rush"
    },
    {
      "game": 3,
      "turn": 1,
      "side": "Red",
      "move": "Recover"
    },
    {
      "game": 3,
      "turn": 1,
      "side": "Blue",
      "move": "Megahorn"
    },
    {
      "game": 3,
      "turn": 2,
      "side": "Red",
      "move": "Ice Beam"
    },
    {
      "game": 3,
      "turn": 2,
      "side": "Blue",
      "move": "Sticky Web"
    },
    {
      "game": 3,
      "turn": 3,
      "side": "Red",
      "move": "Recover"
    },
    {
      "game": 3,
      "turn": 3,
      "side": "Blue",
      "move": "Megahorn"
    },
    {
      "game": 3,
      "turn": 4,
      "side": "Red",
      "move": "Flip Turn"
    },
    {
      "game": 3,
      "turn": 4,
      "side": "Blue",
      "move": "Toxic Spikes"
    },
    {
      "game": 3,
      "turn": 5,
      "side": "Red",
      "move": "Thunderbolt"
    },
    {
      "game": 3,
      "turn": 5,
      "side": "Blue",
      "move": "Toxic Spikes"
    },
    {
      "game": 3,
      "turn": 6,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 6,
      "side": "Blue",
      "move": "Toxic Spikes"
    },
    {
      "game": 3,
      "turn": 7,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 7,
      "side": "Blue",
      "move": "Megahorn"
    },
    {
      "game": 3,
      "turn": 8,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 8,
      "side": "Blue",
      "move": "Toxic Spikes"
    },
    {
      "game": 3,
      "turn": 9,
      "side": "Red",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 9,
      "side": "Blue",
      "move": "Poison Jab"
    },
    {
      "game": 3,
      "turn": 10,
      "side": "Red",
      "move": "Substitute"
    },
    {
      "game": 3,
      "turn": 10,
      "side": "Blue",
      "move": "Poison Jab"
    },
    {
      "game": 3,
      "turn": 11,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 11,
      "side": "Blue",
      "move": "Toxic Spikes"
    },
    {
      "game": 3,
      "turn": 12,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 13,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 13,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 14,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 14,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 15,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 15,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 16,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 16,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 17,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 17,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 18,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 18,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 19,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 19,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 20,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 20,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 21,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 21,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 22,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 22,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 23,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 23,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 24,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 24,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 25,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 25,
      "side": "Red",
      "move": "Sticky Web"
    },
    {
      "game": 3,
      "turn": 26,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 27,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 27,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 28,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 28,
      "side": "Red",
      "move": "Slack Off"
    },
    {
      "game": 3,
      "turn": 29,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 29,
      "side": "Red",
      "move": "Scald"
    },
    {
      "game": 3,
      "turn": 30,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 30,
      "side": "Red",
      "move": "Thunder Wave"
    },
    {
      "game": 3,
      "turn": 31,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 3,
      "turn": 31,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 32,
      "side": "Red",
      "move": "Sludge Wave"
    },
    {
      "game": 3,
      "turn": 32,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 33,
      "side": "Red",
      "move": "Sleep Powder"
    },
    {
      "game": 3,
      "turn": 34,
      "side": "Red",
      "move": "Sludge Wave"
    },
    {
      "game": 3,
      "turn": 34,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 35,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 3,
      "turn": 35,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 36,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 3,
      "turn": 36,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 37,
      "side": "Red",
      "move": "Quiver Dance"
    },
    {
      "game": 3,
      "turn": 37,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 38,
      "side": "Red",
      "move": "Sleep Powder"
    },
    {
      "game": 3,
      "turn": 39,
      "side": "Red",
      "move": "Sludge Wave"
    },
    {
      "game": 3,
      "turn": 39,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 40,
      "side": "Red",
      "move": "Sleep Powder"
    },
    {
      "game": 3,
      "turn": 40,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 41,
      "side": "Red",
      "move": "Bug Buzz"
    },
    {
      "game": 3,
      "turn": 41,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 42,
      "side": "Red",
      "move": "Sludge Wave"
    },
    {
      "game": 3,
      "turn": 42,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 43,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 43,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 44,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 44,
      "side": "Red",
      "move": "Ice Beam"
    },
    {
      "game": 3,
      "turn": 45,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 46,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 46,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 47,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 47,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 48,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 48,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 49,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 49,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 50,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 50,
      "side": "Blue",
      "move": "Moonlight"
    },
    {
      "game": 3,
      "turn": 51,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 51,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 52,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 52,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 53,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 53,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 54,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 54,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 55,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 55,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 56,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 56,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 57,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 57,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 58,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 58,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 59,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 59,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 60,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 60,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 61,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 61,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 62,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 62,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 63,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 63,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 64,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 64,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 65,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 65,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 66,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 66,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 67,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 67,
      "side": "Red",
      "move": "Wish"
    },
    {
      "game": 3,
      "turn": 68,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 68,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 69,
      "side": "Blue",
      "move": "Psyshock"
    },
    {
      "game": 3,
      "turn": 69,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 70,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 70,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 71,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 71,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 72,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 72,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 73,
      "side": "Blue",
      "move": "Moonblast"
    },
    {
      "game": 3,
      "turn": 73,
      "side": "Red",
      "move": "Iron Head"
    },
    {
      "game": 3,
      "turn": 74,
      "side": "Red",
      "move": "Protect"
    },
    {
      "game": 3,
      "turn": 74,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 75,
      "side": "Blue",
      "move": "Calm Mind"
    },
    {
      "game": 3,
      "turn": 75,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 76,
      "side": "Blue",
      "move": "Body Press"
    },
    {
      "game": 3,
      "turn": 76,
      "side": "Red",
      "move": "U-turn"
    },
    {
      "game": 3,
      "turn": 77,
      "side": "Blue",
      "move": "Body Press"
    }
  ]
}
ORACLE_JSON
echo "oracle: wrote 388 moves"

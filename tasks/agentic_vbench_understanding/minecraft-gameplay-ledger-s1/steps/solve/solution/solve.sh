#!/bin/bash
# Oracle: the machine-recorded gameplay ledger (mineflayer events +
# the bot's own placements), in play order, with the weapon per kill.
set -euo pipefail
mkdir -p "$(dirname "${SOLUTION_PATH:-/solution/solution.json}")"
cat > "${SOLUTION_PATH:-/solution/solution.json}" <<'JSON'
{
  "events": [
    {
      "i": 0,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 1,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 2,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 3,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 4,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 5,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 6,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 7,
      "action": "kill",
      "target": "cow",
      "tool": "sword"
    },
    {
      "i": 8,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 9,
      "action": "kill",
      "target": "sheep",
      "tool": "sword"
    },
    {
      "i": 10,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 11,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 12,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 13,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 14,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 15,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 16,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 17,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 18,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 19,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 20,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 21,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 22,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 23,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 24,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 25,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 26,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 27,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 28,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 29,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 30,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 31,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 32,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 33,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 34,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 35,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 36,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 37,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 38,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 39,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 40,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 41,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 42,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 43,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 44,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 45,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 46,
      "action": "place",
      "target": "oak_door"
    },
    {
      "i": 47,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 48,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 49,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 50,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 51,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 52,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 53,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 54,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 55,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 56,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 57,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 58,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 59,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 60,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 61,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 62,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 63,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 64,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 65,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 66,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 67,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 68,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 69,
      "action": "kill",
      "target": "wolf",
      "tool": "sword"
    },
    {
      "i": 70,
      "action": "kill",
      "target": "pig",
      "tool": "bow"
    },
    {
      "i": 71,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 72,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 73,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 74,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 75,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 76,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 77,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 78,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 79,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 80,
      "action": "kill",
      "target": "turtle",
      "tool": "sword"
    },
    {
      "i": 81,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 82,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 83,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 84,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 85,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 86,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 87,
      "action": "mine",
      "target": "cactus"
    },
    {
      "i": 88,
      "action": "mine",
      "target": "cactus"
    },
    {
      "i": 89,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 90,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 91,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 92,
      "action": "kill",
      "target": "sheep",
      "tool": "sword"
    },
    {
      "i": 93,
      "action": "kill",
      "target": "chicken",
      "tool": "bow"
    },
    {
      "i": 94,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 95,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 96,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 97,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 98,
      "action": "mine",
      "target": "ice"
    },
    {
      "i": 99,
      "action": "mine",
      "target": "ice"
    },
    {
      "i": 100,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 101,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 102,
      "action": "kill",
      "target": "mooshroom",
      "tool": "sword"
    },
    {
      "i": 103,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 104,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 105,
      "action": "mine",
      "target": "jungle_log"
    },
    {
      "i": 106,
      "action": "mine",
      "target": "jungle_log"
    },
    {
      "i": 107,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 108,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 109,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 110,
      "action": "kill",
      "target": "panda",
      "tool": "sword"
    },
    {
      "i": 111,
      "action": "kill",
      "target": "mooshroom",
      "tool": "bow"
    },
    {
      "i": 112,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 113,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 114,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 115,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 116,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 117,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 118,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 119,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 120,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 121,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 122,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 123,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 124,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 125,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 126,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 127,
      "action": "kill",
      "target": "polar_bear",
      "tool": "bow"
    },
    {
      "i": 128,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 129,
      "action": "kill",
      "target": "chicken",
      "tool": "sword"
    },
    {
      "i": 130,
      "action": "mine",
      "target": "acacia_log"
    },
    {
      "i": 131,
      "action": "mine",
      "target": "acacia_log"
    },
    {
      "i": 132,
      "action": "mine",
      "target": "acacia_log"
    },
    {
      "i": 133,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 134,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 135,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 136,
      "action": "kill",
      "target": "cow",
      "tool": "sword"
    },
    {
      "i": 137,
      "action": "kill",
      "target": "sheep",
      "tool": "bow"
    },
    {
      "i": 138,
      "action": "kill",
      "target": "mooshroom",
      "tool": "sword"
    },
    {
      "i": 139,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 140,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 141,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 142,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 143,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 144,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 145,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 146,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 147,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 148,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 149,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 150,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 151,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 152,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 153,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 154,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 155,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 156,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 157,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 158,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 159,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 160,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 161,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 162,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 163,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 164,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 165,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 166,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 167,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 168,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 169,
      "action": "kill",
      "target": "mooshroom",
      "tool": "sword"
    },
    {
      "i": 170,
      "action": "kill",
      "target": "sheep",
      "tool": "bow"
    },
    {
      "i": 171,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 172,
      "action": "mine",
      "target": "stone"
    },
    {
      "i": 173,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 174,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 175,
      "action": "mine",
      "target": "coal_ore"
    },
    {
      "i": 176,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 177,
      "action": "mine",
      "target": "stone"
    },
    {
      "i": 178,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 179,
      "action": "mine",
      "target": "iron_ore"
    },
    {
      "i": 180,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 181,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 182,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 183,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 184,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 185,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 186,
      "action": "mine",
      "target": "diamond_ore"
    },
    {
      "i": 187,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 188,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 189,
      "action": "mine",
      "target": "emerald_ore"
    },
    {
      "i": 190,
      "action": "mine",
      "target": "diorite"
    },
    {
      "i": 191,
      "action": "mine",
      "target": "granite"
    },
    {
      "i": 192,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 193,
      "action": "mine",
      "target": "coal_ore"
    },
    {
      "i": 194,
      "action": "mine",
      "target": "stone"
    },
    {
      "i": 195,
      "action": "mine",
      "target": "diorite"
    },
    {
      "i": 196,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 197,
      "action": "mine",
      "target": "iron_ore"
    }
  ]
}
JSON

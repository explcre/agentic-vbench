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
      "target": "birch_log"
    },
    {
      "i": 1,
      "action": "mine",
      "target": "birch_log"
    },
    {
      "i": 2,
      "action": "mine",
      "target": "birch_log"
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
      "target": "sheep",
      "tool": "sword"
    },
    {
      "i": 9,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 10,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 11,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 12,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 13,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 14,
      "action": "place",
      "target": "stone"
    },
    {
      "i": 15,
      "action": "place",
      "target": "stone"
    },
    {
      "i": 16,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 17,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 18,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 19,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 20,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 21,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 22,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 23,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 24,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 25,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 26,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 27,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 28,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 29,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 30,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 31,
      "action": "place",
      "target": "birch_planks"
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
      "target": "oak_planks"
    },
    {
      "i": 39,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 40,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 41,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 42,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 43,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 44,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 45,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 46,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 47,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 48,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 49,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 50,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 51,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 52,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 53,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 54,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 55,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 56,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 57,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 58,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 59,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 60,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 61,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 62,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 63,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 64,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 65,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 66,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 67,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 68,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 69,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 70,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 71,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 72,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 73,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 74,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 75,
      "action": "place",
      "target": "stone"
    },
    {
      "i": 76,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 77,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 78,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 79,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 80,
      "action": "place",
      "target": "oak_door"
    },
    {
      "i": 81,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 82,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 83,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 84,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 85,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 86,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 87,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 88,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 89,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 90,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 91,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 92,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 93,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 94,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 95,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 96,
      "action": "place",
      "target": "stone"
    },
    {
      "i": 97,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 98,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 99,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 100,
      "action": "place",
      "target": "birch_planks"
    },
    {
      "i": 101,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 102,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 103,
      "action": "place",
      "target": "stone"
    },
    {
      "i": 104,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 105,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 106,
      "action": "place",
      "target": "oak_log"
    },
    {
      "i": 107,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 108,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 109,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 110,
      "action": "place",
      "target": "spruce_planks"
    },
    {
      "i": 111,
      "action": "place",
      "target": "oak_planks"
    },
    {
      "i": 112,
      "action": "place",
      "target": "oak_stairs"
    },
    {
      "i": 113,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 114,
      "action": "kill",
      "target": "wolf",
      "tool": "sword"
    },
    {
      "i": 115,
      "action": "kill",
      "target": "pig",
      "tool": "bow"
    },
    {
      "i": 116,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 117,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 118,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 119,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 120,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 121,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 122,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 123,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 124,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 125,
      "action": "kill",
      "target": "turtle",
      "tool": "sword"
    },
    {
      "i": 126,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 127,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 128,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 129,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 130,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 131,
      "action": "mine",
      "target": "sand"
    },
    {
      "i": 132,
      "action": "mine",
      "target": "cactus"
    },
    {
      "i": 133,
      "action": "mine",
      "target": "cactus"
    },
    {
      "i": 134,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 135,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 136,
      "action": "mine",
      "target": "sandstone"
    },
    {
      "i": 137,
      "action": "kill",
      "target": "sheep",
      "tool": "sword"
    },
    {
      "i": 138,
      "action": "kill",
      "target": "chicken",
      "tool": "bow"
    },
    {
      "i": 139,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 140,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 141,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 142,
      "action": "mine",
      "target": "snow"
    },
    {
      "i": 143,
      "action": "mine",
      "target": "ice"
    },
    {
      "i": 144,
      "action": "mine",
      "target": "ice"
    },
    {
      "i": 145,
      "action": "kill",
      "target": "cow",
      "tool": "bow"
    },
    {
      "i": 146,
      "action": "kill",
      "target": "pig",
      "tool": "sword"
    },
    {
      "i": 147,
      "action": "kill",
      "target": "mooshroom",
      "tool": "sword"
    },
    {
      "i": 148,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 149,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 150,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 151,
      "action": "mine",
      "target": "jungle_log"
    },
    {
      "i": 152,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 153,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 154,
      "action": "mine",
      "target": "oak_leaves"
    },
    {
      "i": 155,
      "action": "kill",
      "target": "panda",
      "tool": "sword"
    },
    {
      "i": 156,
      "action": "kill",
      "target": "mooshroom",
      "tool": "bow"
    },
    {
      "i": 157,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 158,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 159,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 160,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 161,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 162,
      "action": "mine",
      "target": "oak_log"
    },
    {
      "i": 163,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 164,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 165,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 166,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 167,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 168,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 169,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 170,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 171,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 172,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 173,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 174,
      "action": "mine",
      "target": "acacia_log"
    },
    {
      "i": 175,
      "action": "mine",
      "target": "acacia_log"
    },
    {
      "i": 176,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 177,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 178,
      "action": "mine",
      "target": "grass_block"
    },
    {
      "i": 179,
      "action": "kill",
      "target": "cow",
      "tool": "sword"
    },
    {
      "i": 180,
      "action": "kill",
      "target": "sheep",
      "tool": "bow"
    },
    {
      "i": 181,
      "action": "kill",
      "target": "mooshroom",
      "tool": "sword"
    },
    {
      "i": 182,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 183,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 184,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 185,
      "action": "mine",
      "target": "red_sand"
    },
    {
      "i": 186,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 187,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 188,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 189,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 190,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 191,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 192,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 193,
      "action": "place",
      "target": "diorite"
    },
    {
      "i": 194,
      "action": "place",
      "target": "diorite"
    },
    {
      "i": 195,
      "action": "place",
      "target": "granite"
    },
    {
      "i": 196,
      "action": "place",
      "target": "glass"
    },
    {
      "i": 197,
      "action": "place",
      "target": "granite"
    },
    {
      "i": 198,
      "action": "place",
      "target": "granite"
    },
    {
      "i": 199,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 200,
      "action": "place",
      "target": "granite"
    },
    {
      "i": 201,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 202,
      "action": "place",
      "target": "cobblestone"
    },
    {
      "i": 203,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 204,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 205,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 206,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 207,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 208,
      "action": "place",
      "target": "diorite"
    },
    {
      "i": 209,
      "action": "place",
      "target": "andesite"
    },
    {
      "i": 210,
      "action": "place",
      "target": "stone_bricks"
    },
    {
      "i": 211,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 212,
      "action": "place",
      "target": "oak_fence"
    },
    {
      "i": 213,
      "action": "mine",
      "target": "stone"
    },
    {
      "i": 214,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 215,
      "action": "mine",
      "target": "coal_ore"
    },
    {
      "i": 216,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 217,
      "action": "mine",
      "target": "cobblestone"
    },
    {
      "i": 218,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 219,
      "action": "mine",
      "target": "iron_ore"
    },
    {
      "i": 220,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 221,
      "action": "mine",
      "target": "stone"
    },
    {
      "i": 222,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 223,
      "action": "mine",
      "target": "gold_ore"
    },
    {
      "i": 224,
      "action": "mine",
      "target": "yellow_terracotta"
    },
    {
      "i": 225,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 226,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 227,
      "action": "mine",
      "target": "redstone_ore"
    },
    {
      "i": 228,
      "action": "mine",
      "target": "brown_terracotta"
    },
    {
      "i": 229,
      "action": "mine",
      "target": "orange_terracotta"
    },
    {
      "i": 230,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 231,
      "action": "mine",
      "target": "lapis_ore"
    },
    {
      "i": 232,
      "action": "mine",
      "target": "andesite"
    },
    {
      "i": 233,
      "action": "mine",
      "target": "yellow_terracotta"
    },
    {
      "i": 234,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 235,
      "action": "mine",
      "target": "diamond_ore"
    },
    {
      "i": 236,
      "action": "mine",
      "target": "granite"
    },
    {
      "i": 237,
      "action": "mine",
      "target": "brown_terracotta"
    },
    {
      "i": 238,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 239,
      "action": "mine",
      "target": "emerald_ore"
    },
    {
      "i": 240,
      "action": "mine",
      "target": "diorite"
    },
    {
      "i": 241,
      "action": "mine",
      "target": "brown_terracotta"
    },
    {
      "i": 242,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 243,
      "action": "mine",
      "target": "coal_ore"
    },
    {
      "i": 244,
      "action": "mine",
      "target": "diorite"
    },
    {
      "i": 245,
      "action": "mine",
      "target": "brown_terracotta"
    },
    {
      "i": 246,
      "action": "place",
      "target": "torch"
    },
    {
      "i": 247,
      "action": "mine",
      "target": "iron_ore"
    }
  ]
}
JSON

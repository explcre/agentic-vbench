#!/bin/bash
# Oracle: verified ordered block-event ledger (build order = bot command log).
set -euo pipefail
mkdir -p /workspace/output
cat > /workspace/output/solution.json <<'ORACLE_JSON'
{
  "events": [
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "place",
      "block": "lapis_block"
    },
    {
      "action": "place",
      "block": "sand"
    },
    {
      "action": "place",
      "block": "netherrack"
    },
    {
      "action": "place",
      "block": "cobblestone"
    },
    {
      "action": "place",
      "block": "emerald_block"
    },
    {
      "action": "place",
      "block": "stone"
    },
    {
      "action": "place",
      "block": "oak_planks"
    },
    {
      "action": "place",
      "block": "bricks"
    },
    {
      "action": "place",
      "block": "gold_block"
    },
    {
      "action": "place",
      "block": "diamond_block"
    },
    {
      "action": "place",
      "block": "redstone_block"
    },
    {
      "action": "break",
      "block": "stone"
    },
    {
      "action": "break",
      "block": "cobblestone"
    },
    {
      "action": "break",
      "block": "sand"
    },
    {
      "action": "break",
      "block": "redstone_block"
    },
    {
      "action": "break",
      "block": "gold_block"
    },
    {
      "action": "break",
      "block": "oak_planks"
    },
    {
      "action": "break",
      "block": "emerald_block"
    },
    {
      "action": "break",
      "block": "netherrack"
    }
  ]
}
ORACLE_JSON
echo "oracle: wrote 80 ordered events"

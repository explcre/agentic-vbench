#!/bin/bash
# Oracle: verified ordered action ledger (mine/kill) from the bot's own events.
set -euo pipefail
mkdir -p /workspace/output
cat > /workspace/output/solution.json <<'ORACLE_JSON'
{
 "events": [
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "birch_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "birch_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "birch_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "birch_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "kill",
   "target": "pig"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "stone"
  }
 ]
}
ORACLE_JSON
echo "oracle: 91 events"

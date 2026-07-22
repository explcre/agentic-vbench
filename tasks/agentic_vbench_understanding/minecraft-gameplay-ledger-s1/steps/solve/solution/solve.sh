#!/bin/bash
set -euo pipefail
mkdir -p /workspace/output
cat > /workspace/output/solution.json <<'ORACLE_JSON'
{
 "events": [
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "kill",
   "target": "cow"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "kill",
   "target": "pig"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "kill",
   "target": "sheep"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "kill",
   "target": "chicken"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "kill",
   "target": "rabbit"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "kill",
   "target": "mooshroom"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "place",
   "target": "oak_planks"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "mine",
   "target": "grass_block"
  },
  {
   "action": "kill",
   "target": "wolf"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "mine",
   "target": "dirt"
  },
  {
   "action": "kill",
   "target": "ocelot"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "kill",
   "target": "fox"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "kill",
   "target": "llama"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "mine",
   "target": "oak_log"
  },
  {
   "action": "kill",
   "target": "cow"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
  }
 ]
}
ORACLE_JSON
echo "oracle: 54 events"

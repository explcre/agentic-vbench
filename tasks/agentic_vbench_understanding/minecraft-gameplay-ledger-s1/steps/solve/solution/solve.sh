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
   "action": "mine",
   "target": "oak_log"
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
   "target": "cow"
  },
  {
   "action": "kill",
   "target": "pig"
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
   "target": "birch_log"
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
   "target": "sheep"
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
   "action": "mine",
   "target": "stone"
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
   "action": "kill",
   "target": "sheep"
  },
  {
   "action": "kill",
   "target": "pig"
  },
  {
   "action": "kill",
   "target": "chicken"
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
   "action": "mine",
   "target": "oak_log"
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
   "target": "oak_leaves"
  },
  {
   "action": "kill",
   "target": "rabbit"
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
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "gravel"
  },
  {
   "action": "mine",
   "target": "diorite"
  },
  {
   "action": "mine",
   "target": "diorite"
  },
  {
   "action": "mine",
   "target": "stone"
  },
  {
   "action": "mine",
   "target": "diorite"
  },
  {
   "action": "mine",
   "target": "diorite"
  },
  {
   "action": "kill",
   "target": "cow"
  },
  {
   "action": "kill",
   "target": "pig"
  },
  {
   "action": "kill",
   "target": "sheep"
  },
  {
   "action": "kill",
   "target": "chicken"
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
   "target": "oak_leaves"
  },
  {
   "action": "mine",
   "target": "oak_leaves"
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
   "action": "mine",
   "target": "oak_log"
  }
 ]
}
ORACLE_JSON
echo "oracle: 73 events"

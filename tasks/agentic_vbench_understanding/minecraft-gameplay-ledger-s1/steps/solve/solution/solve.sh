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
   "action": "mine",
   "target": "gravel"
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
   "target": "oak_log"
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
   "action": "mine",
   "target": "oak_leaves"
  },
  {
   "action": "kill",
   "target": "cow"
  }
 ]
}
ORACLE_JSON
echo "oracle: 55 events"

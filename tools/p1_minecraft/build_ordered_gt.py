#!/usr/bin/env python3
"""Emit P1 ordered ground_truth.json + oracle solve.sh from the bot session log
(session.json). GT = the bot's /setblock command order (machine-exact)."""
import json, sys
from pathlib import Path
sess=json.loads(Path(sys.argv[1]).read_text())["events"]; T=Path(sys.argv[2])
events=[{"action":e["action"],"block":e["block"]} for e in sess]
(T/"steps/solve/tests/ground_truth.json").write_text(json.dumps({"n_events":len(events),"events":events},indent=2))
payload=json.dumps({"events":events},indent=2)
(T/"steps/solve/solution/solve.sh").write_text(
 "#!/bin/bash\nset -euo pipefail\nmkdir -p /workspace/output\n"
 "cat > /workspace/output/solution.json <<'ORACLE_JSON'\n"+payload+"\nORACLE_JSON\n"
 f'echo "oracle: {len(events)} ordered events"\n')
print("wrote", len(events), "ordered events")

#!/usr/bin/env python3
"""From series.json, emit the P2 task's verifier ground truth, oracle solve.sh, and
the teams-vocabulary block for the instruction. Keeps video and answer key in sync."""
import json
import sys
from pathlib import Path

series = json.loads(Path(sys.argv[1]).read_text())
task_dir = Path(sys.argv[2])

# Flatten the ground-truth move ledger across the 3 games.
gt = []
for g in series["games"]:
    for m in g["moves"]:
        gt.append({"game": g["game"], "turn": m["turn"], "side": m["side"], "move": m["move"]})

(task_dir / "steps/solve/tests/ground_truth.json").write_text(
    json.dumps({"n_moves": len(gt), "moves": gt}, indent=2))

# Oracle solve.sh writes the exact ledger.
oracle = {"moves": gt}
payload = json.dumps(oracle, indent=2)
solve = (
    "#!/bin/bash\n"
    "# Oracle: write the verified move ledger. Auto-generated from the same series\n"
    "# seed as the video, so it is the answer key, not an echo. Agent never sees it.\n"
    "set -euo pipefail\n"
    "mkdir -p /workspace/output\n"
    "cat > /workspace/output/solution.json <<'ORACLE_JSON'\n"
    f"{payload}\n"
    "ORACLE_JSON\n"
    f'echo "oracle: wrote {len(gt)} moves"\n'
)
(task_dir / "steps/solve/solution/solve.sh").write_text(solve)

# Teams vocabulary markdown for the instruction (display names).
lines = []
for g in series["games"]:
    lines.append(f"### Game {g['game']}")
    for team_name, mons in g["teams"].items():
        lines.append(f"**{team_name}'s team:**")
        for p in mons:
            lines.append(f"- {p['species']}: {', '.join(p['moves'])}")
        lines.append("")
Path(sys.argv[3]).write_text("\n".join(lines))
print(f"gt moves={len(gt)}; wrote ground_truth.json, solve.sh, vocab -> {sys.argv[3]}")

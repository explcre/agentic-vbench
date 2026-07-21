#!/usr/bin/env python3
"""Parse a Pokemon Showdown omniscient protocol log into the ground-truth ledger.

The ledger is the ordered list of structurally-visible events: every time a Pokemon
becomes active (lead, switch, or forced drag) and every faint, tagged with the turn,
the side, and the species. These are exactly the events a viewer can read off the
muted battle scene (sprite changes + HP bars). Move names live only in the text log,
which the rendered video hides, so they are deliberately NOT in the ledger.
"""
import json
import sys


def parse(log_text):
    turn = 0
    active = {"p1a": None, "p2a": None, "p1b": None, "p2b": None}
    events = []
    for line in log_text.splitlines():
        if not line.startswith("|"):
            continue
        p = line.split("|")
        tag = p[1] if len(p) > 1 else ""
        if tag == "turn":
            turn = int(p[2])
        elif tag in ("switch", "drag"):
            slot_name = p[2]                       # "p1a: Grumpig"
            slot = slot_name.split(":")[0].strip()  # "p1a"
            species = p[3].split(",")[0].strip()    # "Grumpig"
            active[slot] = species
            events.append({"turn": turn, "side": slot[:2],
                           "event": "switch_in", "species": species})
        elif tag == "faint":
            slot = p[2].split(":")[0].strip()
            species = active.get(slot)
            events.append({"turn": turn, "side": slot[:2],
                           "event": "faint", "species": species})
    max_turn = turn
    return {"battle_turns": max_turn, "events": events}


if __name__ == "__main__":
    data = parse(sys.stdin.read())
    json.dump(data, sys.stdout, indent=2)
    print(f"\n# turns={data['battle_turns']} events={len(data['events'])} "
          f"switch_ins={sum(e['event']=='switch_in' for e in data['events'])} "
          f"faints={sum(e['event']=='faint' for e in data['events'])}", file=sys.stderr)

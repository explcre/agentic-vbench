#!/bin/bash
# Oracle: emit the verified structural ledger. Answer key, not an echo of input.
# Auto-generated from the frozen battle logs; the agent never sees this.
set -euo pipefail
mkdir -p /workspace/output
cat > /workspace/output/solution.json <<'ORACLE_JSON'
{
  "events": [
    {
      "game": 1,
      "turn": 0,
      "side": "p1",
      "event": "switch_in",
      "species": "Golem-Alola"
    },
    {
      "game": 1,
      "turn": 0,
      "side": "p2",
      "event": "switch_in",
      "species": "Uxie"
    },
    {
      "game": 1,
      "turn": 3,
      "side": "p2",
      "event": "faint",
      "species": "Uxie"
    },
    {
      "game": 1,
      "turn": 3,
      "side": "p2",
      "event": "switch_in",
      "species": "Serperior"
    },
    {
      "game": 1,
      "turn": 4,
      "side": "p1",
      "event": "faint",
      "species": "Golem-Alola"
    },
    {
      "game": 1,
      "turn": 4,
      "side": "p1",
      "event": "switch_in",
      "species": "Hariyama"
    },
    {
      "game": 1,
      "turn": 7,
      "side": "p2",
      "event": "faint",
      "species": "Serperior"
    },
    {
      "game": 1,
      "turn": 7,
      "side": "p2",
      "event": "switch_in",
      "species": "Dedenne"
    },
    {
      "game": 1,
      "turn": 9,
      "side": "p2",
      "event": "switch_in",
      "species": "Stonjourner"
    },
    {
      "game": 1,
      "turn": 10,
      "side": "p1",
      "event": "faint",
      "species": "Hariyama"
    },
    {
      "game": 1,
      "turn": 10,
      "side": "p1",
      "event": "switch_in",
      "species": "Gurdurr"
    },
    {
      "game": 1,
      "turn": 14,
      "side": "p2",
      "event": "faint",
      "species": "Stonjourner"
    },
    {
      "game": 1,
      "turn": 14,
      "side": "p2",
      "event": "switch_in",
      "species": "Dedenne"
    },
    {
      "game": 1,
      "turn": 15,
      "side": "p1",
      "event": "faint",
      "species": "Gurdurr"
    },
    {
      "game": 1,
      "turn": 15,
      "side": "p1",
      "event": "switch_in",
      "species": "Archaludon"
    },
    {
      "game": 1,
      "turn": 18,
      "side": "p2",
      "event": "faint",
      "species": "Dedenne"
    },
    {
      "game": 1,
      "turn": 18,
      "side": "p2",
      "event": "switch_in",
      "species": "Hypno"
    },
    {
      "game": 1,
      "turn": 19,
      "side": "p1",
      "event": "faint",
      "species": "Archaludon"
    },
    {
      "game": 1,
      "turn": 19,
      "side": "p1",
      "event": "switch_in",
      "species": "Groudon"
    },
    {
      "game": 1,
      "turn": 23,
      "side": "p2",
      "event": "faint",
      "species": "Hypno"
    },
    {
      "game": 1,
      "turn": 23,
      "side": "p2",
      "event": "switch_in",
      "species": "Maushold-Four"
    },
    {
      "game": 1,
      "turn": 24,
      "side": "p2",
      "event": "faint",
      "species": "Maushold-Four"
    },
    {
      "game": 2,
      "turn": 0,
      "side": "p1",
      "event": "switch_in",
      "species": "Gyarados"
    },
    {
      "game": 2,
      "turn": 0,
      "side": "p2",
      "event": "switch_in",
      "species": "Noivern"
    },
    {
      "game": 2,
      "turn": 6,
      "side": "p1",
      "event": "faint",
      "species": "Gyarados"
    },
    {
      "game": 2,
      "turn": 6,
      "side": "p1",
      "event": "switch_in",
      "species": "Okidogi"
    },
    {
      "game": 2,
      "turn": 8,
      "side": "p2",
      "event": "faint",
      "species": "Noivern"
    },
    {
      "game": 2,
      "turn": 8,
      "side": "p2",
      "event": "switch_in",
      "species": "Groudon"
    },
    {
      "game": 2,
      "turn": 12,
      "side": "p1",
      "event": "faint",
      "species": "Okidogi"
    },
    {
      "game": 2,
      "turn": 12,
      "side": "p1",
      "event": "switch_in",
      "species": "Quagsire"
    },
    {
      "game": 2,
      "turn": 17,
      "side": "p2",
      "event": "faint",
      "species": "Groudon"
    },
    {
      "game": 2,
      "turn": 17,
      "side": "p2",
      "event": "switch_in",
      "species": "Venusaur"
    },
    {
      "game": 2,
      "turn": 18,
      "side": "p1",
      "event": "faint",
      "species": "Quagsire"
    },
    {
      "game": 2,
      "turn": 18,
      "side": "p1",
      "event": "switch_in",
      "species": "Talonflame"
    },
    {
      "game": 2,
      "turn": 24,
      "side": "p2",
      "event": "faint",
      "species": "Venusaur"
    },
    {
      "game": 2,
      "turn": 24,
      "side": "p1",
      "event": "switch_in",
      "species": "Cresselia"
    },
    {
      "game": 2,
      "turn": 24,
      "side": "p2",
      "event": "switch_in",
      "species": "Zamazenta"
    },
    {
      "game": 2,
      "turn": 30,
      "side": "p2",
      "event": "faint",
      "species": "Zamazenta"
    },
    {
      "game": 2,
      "turn": 30,
      "side": "p2",
      "event": "switch_in",
      "species": "Terrakion"
    },
    {
      "game": 2,
      "turn": 31,
      "side": "p2",
      "event": "faint",
      "species": "Terrakion"
    },
    {
      "game": 2,
      "turn": 31,
      "side": "p2",
      "event": "switch_in",
      "species": "Azumarill"
    },
    {
      "game": 2,
      "turn": 33,
      "side": "p1",
      "event": "faint",
      "species": "Cresselia"
    },
    {
      "game": 2,
      "turn": 33,
      "side": "p1",
      "event": "switch_in",
      "species": "Uxie"
    },
    {
      "game": 2,
      "turn": 36,
      "side": "p2",
      "event": "faint",
      "species": "Azumarill"
    },
    {
      "game": 3,
      "turn": 0,
      "side": "p1",
      "event": "switch_in",
      "species": "Cyclizar"
    },
    {
      "game": 3,
      "turn": 0,
      "side": "p2",
      "event": "switch_in",
      "species": "Mudsdale"
    },
    {
      "game": 3,
      "turn": 1,
      "side": "p1",
      "event": "switch_in",
      "species": "Shiftry"
    },
    {
      "game": 3,
      "turn": 4,
      "side": "p2",
      "event": "faint",
      "species": "Mudsdale"
    },
    {
      "game": 3,
      "turn": 4,
      "side": "p2",
      "event": "switch_in",
      "species": "Kricketune"
    },
    {
      "game": 3,
      "turn": 8,
      "side": "p2",
      "event": "faint",
      "species": "Kricketune"
    },
    {
      "game": 3,
      "turn": 8,
      "side": "p2",
      "event": "switch_in",
      "species": "Frosmoth"
    },
    {
      "game": 3,
      "turn": 9,
      "side": "p1",
      "event": "faint",
      "species": "Shiftry"
    },
    {
      "game": 3,
      "turn": 9,
      "side": "p1",
      "event": "switch_in",
      "species": "Kyurem-White"
    },
    {
      "game": 3,
      "turn": 10,
      "side": "p2",
      "event": "faint",
      "species": "Frosmoth"
    },
    {
      "game": 3,
      "turn": 10,
      "side": "p2",
      "event": "switch_in",
      "species": "Dragalge"
    },
    {
      "game": 3,
      "turn": 11,
      "side": "p1",
      "event": "faint",
      "species": "Kyurem-White"
    },
    {
      "game": 3,
      "turn": 11,
      "side": "p1",
      "event": "switch_in",
      "species": "Typhlosion-Hisui"
    },
    {
      "game": 3,
      "turn": 16,
      "side": "p1",
      "event": "faint",
      "species": "Typhlosion-Hisui"
    },
    {
      "game": 3,
      "turn": 16,
      "side": "p1",
      "event": "switch_in",
      "species": "Cyclizar"
    },
    {
      "game": 3,
      "turn": 19,
      "side": "p1",
      "event": "faint",
      "species": "Cyclizar"
    },
    {
      "game": 3,
      "turn": 19,
      "side": "p1",
      "event": "switch_in",
      "species": "Iron Boulder"
    },
    {
      "game": 3,
      "turn": 23,
      "side": "p2",
      "event": "faint",
      "species": "Dragalge"
    },
    {
      "game": 3,
      "turn": 23,
      "side": "p2",
      "event": "switch_in",
      "species": "Zacian"
    },
    {
      "game": 3,
      "turn": 24,
      "side": "p1",
      "event": "faint",
      "species": "Iron Boulder"
    },
    {
      "game": 3,
      "turn": 24,
      "side": "p1",
      "event": "switch_in",
      "species": "Swalot"
    },
    {
      "game": 3,
      "turn": 25,
      "side": "p2",
      "event": "faint",
      "species": "Zacian"
    },
    {
      "game": 3,
      "turn": 25,
      "side": "p2",
      "event": "switch_in",
      "species": "Mandibuzz"
    },
    {
      "game": 3,
      "turn": 32,
      "side": "p2",
      "event": "faint",
      "species": "Mandibuzz"
    },
    {
      "game": 4,
      "turn": 0,
      "side": "p1",
      "event": "switch_in",
      "species": "Clawitzer"
    },
    {
      "game": 4,
      "turn": 0,
      "side": "p2",
      "event": "switch_in",
      "species": "Mesprit"
    },
    {
      "game": 4,
      "turn": 1,
      "side": "p1",
      "event": "switch_in",
      "species": "Blastoise"
    },
    {
      "game": 4,
      "turn": 3,
      "side": "p1",
      "event": "faint",
      "species": "Blastoise"
    },
    {
      "game": 4,
      "turn": 3,
      "side": "p1",
      "event": "switch_in",
      "species": "Mightyena"
    },
    {
      "game": 4,
      "turn": 4,
      "side": "p2",
      "event": "faint",
      "species": "Mesprit"
    },
    {
      "game": 4,
      "turn": 4,
      "side": "p2",
      "event": "switch_in",
      "species": "Chien-Pao"
    },
    {
      "game": 4,
      "turn": 6,
      "side": "p1",
      "event": "faint",
      "species": "Mightyena"
    },
    {
      "game": 4,
      "turn": 6,
      "side": "p1",
      "event": "switch_in",
      "species": "Lurantis"
    },
    {
      "game": 4,
      "turn": 7,
      "side": "p2",
      "event": "faint",
      "species": "Chien-Pao"
    },
    {
      "game": 4,
      "turn": 7,
      "side": "p2",
      "event": "switch_in",
      "species": "Dedenne"
    },
    {
      "game": 4,
      "turn": 11,
      "side": "p2",
      "event": "faint",
      "species": "Dedenne"
    },
    {
      "game": 4,
      "turn": 11,
      "side": "p2",
      "event": "switch_in",
      "species": "Ceruledge"
    },
    {
      "game": 4,
      "turn": 13,
      "side": "p1",
      "event": "faint",
      "species": "Lurantis"
    },
    {
      "game": 4,
      "turn": 13,
      "side": "p1",
      "event": "switch_in",
      "species": "Gardevoir"
    },
    {
      "game": 4,
      "turn": 14,
      "side": "p1",
      "event": "faint",
      "species": "Gardevoir"
    },
    {
      "game": 4,
      "turn": 14,
      "side": "p1",
      "event": "switch_in",
      "species": "Appletun"
    },
    {
      "game": 4,
      "turn": 19,
      "side": "p2",
      "event": "faint",
      "species": "Ceruledge"
    },
    {
      "game": 4,
      "turn": 19,
      "side": "p2",
      "event": "switch_in",
      "species": "Primarina"
    },
    {
      "game": 4,
      "turn": 21,
      "side": "p1",
      "event": "faint",
      "species": "Appletun"
    },
    {
      "game": 4,
      "turn": 21,
      "side": "p1",
      "event": "switch_in",
      "species": "Clawitzer"
    },
    {
      "game": 4,
      "turn": 25,
      "side": "p1",
      "event": "faint",
      "species": "Clawitzer"
    },
    {
      "game": 5,
      "turn": 0,
      "side": "p1",
      "event": "switch_in",
      "species": "Scovillain"
    },
    {
      "game": 5,
      "turn": 0,
      "side": "p2",
      "event": "switch_in",
      "species": "Lunala"
    },
    {
      "game": 5,
      "turn": 22,
      "side": "p1",
      "event": "faint",
      "species": "Scovillain"
    },
    {
      "game": 5,
      "turn": 22,
      "side": "p1",
      "event": "switch_in",
      "species": "Garganacl"
    },
    {
      "game": 5,
      "turn": 24,
      "side": "p2",
      "event": "faint",
      "species": "Lunala"
    },
    {
      "game": 5,
      "turn": 24,
      "side": "p2",
      "event": "switch_in",
      "species": "Sunflora"
    },
    {
      "game": 5,
      "turn": 26,
      "side": "p1",
      "event": "faint",
      "species": "Garganacl"
    },
    {
      "game": 5,
      "turn": 26,
      "side": "p1",
      "event": "switch_in",
      "species": "Charizard"
    },
    {
      "game": 5,
      "turn": 30,
      "side": "p2",
      "event": "faint",
      "species": "Sunflora"
    },
    {
      "game": 5,
      "turn": 30,
      "side": "p2",
      "event": "switch_in",
      "species": "Manaphy"
    },
    {
      "game": 5,
      "turn": 33,
      "side": "p1",
      "event": "faint",
      "species": "Charizard"
    },
    {
      "game": 5,
      "turn": 33,
      "side": "p1",
      "event": "switch_in",
      "species": "Banette"
    },
    {
      "game": 5,
      "turn": 34,
      "side": "p2",
      "event": "faint",
      "species": "Manaphy"
    },
    {
      "game": 5,
      "turn": 34,
      "side": "p2",
      "event": "switch_in",
      "species": "Corviknight"
    },
    {
      "game": 5,
      "turn": 36,
      "side": "p1",
      "event": "faint",
      "species": "Banette"
    },
    {
      "game": 5,
      "turn": 36,
      "side": "p1",
      "event": "switch_in",
      "species": "Cresselia"
    },
    {
      "game": 5,
      "turn": 37,
      "side": "p2",
      "event": "switch_in",
      "species": "Toedscruel"
    },
    {
      "game": 5,
      "turn": 51,
      "side": "p2",
      "event": "faint",
      "species": "Toedscruel"
    },
    {
      "game": 5,
      "turn": 51,
      "side": "p2",
      "event": "switch_in",
      "species": "Corviknight"
    },
    {
      "game": 5,
      "turn": 53,
      "side": "p2",
      "event": "switch_in",
      "species": "Mabosstiff"
    },
    {
      "game": 5,
      "turn": 56,
      "side": "p1",
      "event": "faint",
      "species": "Cresselia"
    },
    {
      "game": 5,
      "turn": 56,
      "side": "p1",
      "event": "switch_in",
      "species": "Falinks"
    },
    {
      "game": 5,
      "turn": 57,
      "side": "p2",
      "event": "faint",
      "species": "Mabosstiff"
    },
    {
      "game": 5,
      "turn": 57,
      "side": "p2",
      "event": "switch_in",
      "species": "Corviknight"
    },
    {
      "game": 5,
      "turn": 59,
      "side": "p1",
      "event": "faint",
      "species": "Falinks"
    }
  ]
}
ORACLE_JSON
echo "oracle: wrote /workspace/output/solution.json (115 events)"

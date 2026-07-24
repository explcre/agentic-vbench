#!/bin/bash
# Oracle: SuperTuxKart's own profile-mode result table for each recorded race.
set -euo pipefail
mkdir -p "$(dirname "${SOLUTION_PATH:-/solution/solution.json}")"
cat > "${SOLUTION_PATH:-/solution/solution.json}" <<'JSON'
{
  "races": [
    {
      "track": "hacienda",
      "karts": [
        {
          "kart": "beastie",
          "finish_position": 1,
          "items_collected": 17
        },
        {
          "kart": "amanda",
          "finish_position": 2,
          "items_collected": 15
        },
        {
          "kart": "kiki",
          "finish_position": 3,
          "items_collected": 22
        },
        {
          "kart": "gnu",
          "finish_position": 4,
          "items_collected": 17
        },
        {
          "kart": "adiumy",
          "finish_position": 5,
          "items_collected": 16
        },
        {
          "kart": "tux",
          "finish_position": 6,
          "items_collected": 19
        }
      ]
    },
    {
      "track": "snowmountain",
      "karts": [
        {
          "kart": "wilber",
          "finish_position": 1,
          "items_collected": 19
        },
        {
          "kart": "xue",
          "finish_position": 2,
          "items_collected": 16
        },
        {
          "kart": "puffy",
          "finish_position": 3,
          "items_collected": 6
        },
        {
          "kart": "pidgin",
          "finish_position": 4,
          "items_collected": 7
        },
        {
          "kart": "konqi",
          "finish_position": 5,
          "items_collected": 11
        },
        {
          "kart": "hexley",
          "finish_position": 6,
          "items_collected": 12
        }
      ]
    },
    {
      "track": "lighthouse",
      "karts": [
        {
          "kart": "sara_the_wizard",
          "finish_position": 1,
          "items_collected": 10
        },
        {
          "kart": "nolok",
          "finish_position": 2,
          "items_collected": 11
        },
        {
          "kart": "emule",
          "finish_position": 3,
          "items_collected": 13
        },
        {
          "kart": "suzanne",
          "finish_position": 4,
          "items_collected": 12
        },
        {
          "kart": "gavroche",
          "finish_position": 5,
          "items_collected": 8
        },
        {
          "kart": "sara_the_racer",
          "finish_position": 6,
          "items_collected": 10
        }
      ]
    },
    {
      "track": "cornfield_crossing",
      "karts": [
        {
          "kart": "konqi",
          "finish_position": 1,
          "items_collected": 7
        },
        {
          "kart": "nolok",
          "finish_position": 2,
          "items_collected": 4
        },
        {
          "kart": "tux",
          "finish_position": 3,
          "items_collected": 8
        },
        {
          "kart": "amanda",
          "finish_position": 4,
          "items_collected": 4
        },
        {
          "kart": "puffy",
          "finish_position": 5,
          "items_collected": 4
        },
        {
          "kart": "wilber",
          "finish_position": 6,
          "items_collected": 4
        }
      ]
    }
  ]
}
JSON

#!/bin/bash
# Assert that the SuperTuxKart config written under a race's config home leaves the powerup
# indicator at its DEFAULT placement and size.
#
# generator/hud_mask.py derives the mask rectangle for the default centred indicator at 64 px
# (display 0). A config that moved the indicator to the side (display 1), hid it (display 2) or
# resized it would put sprites outside that rectangle, so the shipped media would leak the very
# thing the mask exists to hide. This is asserted on the config the race actually wrote, not on the
# environment it inherited.
#
# Usage: check_hud_config.sh STKHOME_DIR     (exit 0 = defaults, 11 = no config, 12 = not default)
set -uo pipefail
HOME_DIR=${1:?usage: check_hud_config.sh STKHOME_DIR}

CFG=$(find "$HOME_DIR" -name config.xml -print -quit 2>/dev/null || true)
if [ -z "$CFG" ]; then
  echo "check_hud_config: no config.xml under $HOME_DIR; cannot confirm default HUD placement"
  exit 11
fi

POW=$(sed -n '/<PowerUp/,/<\/PowerUp>/p' "$CFG")
if ! printf '%s' "$POW" | grep -q 'display="0"'; then
  echo "check_hud_config: powerup indicator is NOT at the default centre placement in $CFG"
  exit 12
fi
if ! printf '%s' "$POW" | grep -q 'powerup-icon-size="64'; then
  echo "check_hud_config: powerup icon size is NOT the default 64 px in $CFG"
  exit 12
fi
echo "check_hud_config: OK, default centred indicator at 64 px ($CFG)"

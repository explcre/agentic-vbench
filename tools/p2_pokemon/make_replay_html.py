#!/usr/bin/env python3
"""Wrap a PS spectator log into a self-contained replay HTML that replay-embed.js
plays. The battle-log text panel is hidden with CSS so the rendered video contains
only the animated field (no move names to OCR)."""
import sys
from pathlib import Path

log_path, out_html = Path(sys.argv[1]), Path(sys.argv[2])
log = log_path.read_text()

HTML = """<!DOCTYPE html>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width" />
<title>replay</title>
<style>
  html, body { margin: 0; padding: 0; background: #0b0b12; overflow: hidden; }
  /* Hide the text battle log, chat, controls, nav, ads: only the field remains. */
  .battle-log, .replay-controls, .battle-log-add, .chat, header, .foralerts,
  .wrapper .replay-controls, .battle-options, .adz, [data-ad] { display: none !important; }
  /* CRITICAL anti-shortcut: the in-scene message bar prints the move name
     ("X used Thunderbolt!") — hide it so moves can't be OCR'd, only inferred. */
  .battle .messagebar, .battle .message { display: none !important; visibility: hidden !important; }
  .battle { margin: 0 !important; }
</style>
<script type="text/plain" class="battle-log-data">
%s
</script>
<script src="https://play.pokemonshowdown.com/js/replay-embed.js"></script>
""" % log

out_html.write_text(HTML)
print(f"wrote {out_html} ({len(HTML)} bytes)")

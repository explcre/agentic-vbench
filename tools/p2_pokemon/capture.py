#!/usr/bin/env python3
"""Record a PS replay to video: field only (text log hidden), scaled to fill 720p.

Playwright records the whole viewport as webm; we scale the .battle element to fill
the viewport and hide everything else, so the recording is exactly the animated field.

Usage: capture.py <replay.html> <out_dir> <speed> <max_seconds>
  speed in {Hyperfast,Fast,Normal,Slow,Really Slow}
Writes <out_dir>/capture.webm (raw) — convert to mp4 separately.
"""
import sys
from pathlib import Path
from playwright.sync_api import sync_playwright

html = Path(sys.argv[1]).resolve()
outdir = Path(sys.argv[2]); outdir.mkdir(parents=True, exist_ok=True)
speed = sys.argv[3] if len(sys.argv) > 3 else "Fast"
max_seconds = int(sys.argv[4]) if len(sys.argv) > 4 else 60

FILL_CSS = """
  html, body { margin:0; padding:0; background:#000; overflow:hidden; }
  header, .replay-controls, .battle-log, .chat, .adz, [data-ad],
  .battle-options, .foralerts { display:none !important; }
  /* scale the field to fill a 1280x720 viewport (battle is ~640x360) */
  .battle { position:fixed !important; left:0 !important; top:0 !important;
            transform: scale(2.0); transform-origin: top left; margin:0 !important; }
"""

with sync_playwright() as p:
    b = p.chromium.launch(args=["--no-sandbox", "--disable-dev-shm-usage"])
    ctx = b.new_context(
        viewport={"width": 1280, "height": 720},
        record_video_dir=str(outdir),
        record_video_size={"width": 1280, "height": 720},
    )
    page = ctx.new_page()
    page.goto(f"file://{html}", wait_until="load")
    page.wait_for_selector(".battle", timeout=45000)
    page.wait_for_timeout(2500)                 # let sprites finish loading
    # set speed, then start with sound off
    try:
        page.click(f"text={speed}", timeout=3000)
    except Exception as e:
        print("speed click failed:", e)
    page.add_style_tag(content=FILL_CSS)        # hide chrome AFTER controls clicked
    try:
        page.click("text=Play (sound off)", timeout=3000)
    except Exception:
        page.click("text=Play", timeout=3000)
    # play for up to max_seconds; stop early if the restart 'Play' button reappears
    elapsed = 0
    ended = False
    while elapsed < max_seconds:
        page.wait_for_timeout(1000)
        elapsed += 1
        if elapsed > 5:
            vis = page.evaluate(
                "() => { const b=[...document.querySelectorAll('button')]"
                ".find(x=>/^\\s*(\\u25b6\\s*)?Play\\s*$/.test(x.textContent));"
                " return b ? (b.offsetParent!==null) : false; }"
            )
            if vis:
                ended = True
                break
    print(f"played ~{elapsed}s ended={ended}")
    path = page.video.path()
    ctx.close()          # finalizes the webm
    b.close()
    print("video:", path)

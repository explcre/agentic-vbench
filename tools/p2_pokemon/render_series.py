#!/usr/bin/env python3
"""Render the Bo3 series to one mp4: capture each game's replay (field only, move
text hidden), insert a 'GAME n' title card before each, and concatenate.

Usage: render_series.py <series_dir> <out_mp4> <ffmpeg> <speed>
Expects <series_dir>/game{1,2,3}.log (from gen_series.js).
"""
import subprocess
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw
from playwright.sync_api import sync_playwright

series_dir = Path(sys.argv[1])
out_mp4 = Path(sys.argv[2])
FF = sys.argv[3]
SPEED = sys.argv[4] if len(sys.argv) > 4 else "Fast"
W, H, FPS = 1280, 720, 25

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
FILL_CSS = """
  html, body { margin:0; padding:0; background:#000; overflow:hidden; }
  header, .replay-controls, .battle-log, .chat, .adz, [data-ad],
  .battle-options, .foralerts { display:none !important; }
  .battle .messagebar, .battle .message { display:none !important; visibility:hidden !important; }
  .battle { position:fixed !important; left:0 !important; top:0 !important;
            transform: scale(1.9); transform-origin: top left; margin:0 !important; }
"""


def make_replay_html(log_path, html_path):
    log = Path(log_path).read_text()
    html = (
        '<!DOCTYPE html><meta charset="utf-8"/>'
        '<style>html,body{margin:0;background:#0b0b12;overflow:hidden}'
        '.battle-log,.messagebar,.message{display:none!important}</style>'
        '<script type="text/plain" class="battle-log-data">\n' + log + '\n</script>'
        '<script src="https://play.pokemonshowdown.com/js/replay-embed.js"></script>'
    )
    Path(html_path).write_text(html)


def capture_game(html_path, webm_dir, speed, final_turn, max_seconds=900):
    """Record until the on-screen turn counter reaches final_turn (then a short tail),
    or max_seconds. Speed is forced by clicking the speed button before playing."""
    webm_dir.mkdir(parents=True, exist_ok=True)
    with sync_playwright() as p:
        b = p.chromium.launch(args=["--no-sandbox", "--disable-dev-shm-usage"])
        ctx = b.new_context(viewport={"width": W, "height": H},
                            record_video_dir=str(webm_dir),
                            record_video_size={"width": W, "height": H})
        page = ctx.new_page()
        page.goto(f"file://{Path(html_path).resolve()}", wait_until="load")
        page.wait_for_selector(".battle", timeout=45000)
        page.wait_for_timeout(2500)
        for label in (speed, "Play (sound off)", "Play"):
            try:
                page.click(f"text={label}", timeout=2500)
            except Exception:
                pass
        page.add_style_tag(content=FILL_CSS)
        elapsed = 0
        done_at = None
        while elapsed < max_seconds:
            page.wait_for_timeout(1000)
            elapsed += 1
            cur = page.evaluate(
                "() => { const m=(document.querySelector('.battle').textContent||'')"
                ".match(/Turn (\\d+)/g); if(!m) return 0;"
                " return Math.max(...m.map(s=>parseInt(s.slice(5),10))); }")
            if cur >= final_turn and done_at is None:
                done_at = elapsed            # let the last turn's animation finish
            if done_at is not None and elapsed - done_at >= 5:
                break
        path = page.video.path()
        ctx.close()
        b.close()
    return path, elapsed


def title_card(text, png_path):
    img = Image.new("RGB", (W, H), (11, 11, 18))
    d = ImageDraw.Draw(img)
    # default bitmap font scaled up by drawing large via anchor; keep simple + legible
    tw = d.textlength(text) if hasattr(d, "textlength") else len(text) * 6
    d.text((W // 2 - tw * 3, H // 2 - 20), text, fill=(235, 235, 245))
    img = img.resize((W, H), Image.NEAREST)
    img.save(png_path)


def to_mp4(src, dst, extra_in=None):
    cmd = [FF, "-y", "-loglevel", "error"]
    if extra_in:
        cmd += extra_in
    cmd += ["-i", str(src), "-r", str(FPS), "-s", f"{W}x{H}",
            "-c:v", "libx264", "-pix_fmt", "yuv420p", "-an", str(dst)]
    subprocess.run(cmd, check=True)


def main():
    import json
    series = json.loads((series_dir / "series.json").read_text())
    final_turns = {gm["game"]: gm["num_turns"] for gm in series["games"]}
    tmp = series_dir / "render_tmp"
    tmp.mkdir(exist_ok=True)
    parts = []
    for g in (1, 2, 3):
        log = series_dir / f"game{g}.log"
        if not log.exists():
            continue
        # title card (2.5s)
        card_png = tmp / f"card{g}.png"
        title_card(f"GAME {g}", card_png)
        card_mp4 = tmp / f"card{g}.mp4"
        to_mp4(card_png, card_mp4, extra_in=["-loop", "1", "-t", "2.5", "-framerate", str(FPS)])
        parts.append(card_mp4)
        # capture + transcode
        html = tmp / f"game{g}.html"
        make_replay_html(log, html)
        webm, secs = capture_game(html, tmp / f"webm{g}", SPEED, final_turns[g])
        game_mp4 = tmp / f"game{g}.mp4"
        to_mp4(webm, game_mp4)
        parts.append(game_mp4)
        print(f"game{g} rendered in ~{secs}s (final turn {final_turns[g]}) -> {game_mp4}", flush=True)
    # concat
    listf = tmp / "concat.txt"
    listf.write_text("".join(f"file '{p.resolve()}'\n" for p in parts))
    subprocess.run([FF, "-y", "-loglevel", "error", "-f", "concat", "-safe", "0",
                    "-i", str(listf), "-c:v", "libx264", "-pix_fmt", "yuv420p",
                    "-r", str(FPS), str(out_mp4)], check=True)
    print(f"FINAL -> {out_mp4}", flush=True)


if __name__ == "__main__":
    main()

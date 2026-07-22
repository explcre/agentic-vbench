#!/usr/bin/env python3
"""Post-process existing game webms into the final series mp4: crop the battle field
to 16:9, scale to 720p (removes controls + black margins), slow 1.2x to clear the
10-min floor, and splice GAME n title cards between games. No re-capture.

Usage: repackage_series.py <series_dir> <out_mp4> <ffmpeg>
"""
import subprocess
import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

series_dir = Path(sys.argv[1])
out_mp4 = Path(sys.argv[2])
FF = sys.argv[3]
W, H, FPS = 1280, 720, 25
SLOW = 1.2                       # playback slowdown factor
CROP = "crop=640:360:0:0,scale=1280:720"

tmp = series_dir / "repack_tmp"
tmp.mkdir(exist_ok=True)


def font(size):
    for p in ("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
              "/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf"):
        if Path(p).exists():
            return ImageFont.truetype(p, size)
    return ImageFont.load_default()


def title_card(text, mp4):
    img = Image.new("RGB", (W, H), (11, 11, 18))
    d = ImageDraw.Draw(img)
    f = font(96)
    try:
        bb = d.textbbox((0, 0), text, font=f)
        tw, th = bb[2] - bb[0], bb[3] - bb[1]
    except Exception:
        tw, th = len(text) * 48, 96
    d.text(((W - tw) // 2, (H - th) // 2 - 20), text, fill=(235, 235, 245), font=f)
    png = tmp / (text.replace(" ", "_") + ".png")
    img.save(png)
    subprocess.run([FF, "-y", "-loglevel", "error", "-loop", "1", "-t", "2.5",
                    "-framerate", str(FPS), "-i", str(png), "-r", str(FPS),
                    "-s", f"{W}x{H}", "-c:v", "libx264", "-pix_fmt", "yuv420p",
                    "-an", str(mp4)], check=True)


def game_clip(webm, mp4):
    subprocess.run([FF, "-y", "-loglevel", "error", "-i", str(webm),
                    "-vf", f"{CROP},setpts={SLOW}*PTS", "-r", str(FPS),
                    "-c:v", "libx264", "-pix_fmt", "yuv420p", "-an", str(mp4)],
                   check=True)


def main():
    parts = []
    for g in (1, 2, 3):
        webms = sorted((series_dir / f"render_tmp/webm{g}").glob("*.webm"))
        if not webms:
            print(f"WARN: no webm for game{g}")
            continue
        card = tmp / f"card{g}.mp4"
        title_card(f"GAME {g}", card)
        parts.append(card)
        clip = tmp / f"game{g}.mp4"
        game_clip(webms[0], clip)
        parts.append(clip)
        print(f"game{g} repackaged", flush=True)
    listf = tmp / "concat.txt"
    listf.write_text("".join(f"file '{p.resolve()}'\n" for p in parts))
    subprocess.run([FF, "-y", "-loglevel", "error", "-f", "concat", "-safe", "0",
                    "-i", str(listf), "-c:v", "libx264", "-pix_fmt", "yuv420p",
                    "-r", str(FPS), str(out_mp4)], check=True)
    print(f"FINAL -> {out_mp4}", flush=True)


if __name__ == "__main__":
    main()

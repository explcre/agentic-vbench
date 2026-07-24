#!/usr/bin/env python3
"""Classify a captured Minecraft frame as `world`, `ui` or `flat`, so a recording is never started
against a screen that is not the game.

    screen_state.py FRAME.png       -> "world dominant=0.13 colours=161 menu_buttons=0"
                                       exit 0 if the frame is the world, 1 otherwise

Both signals were calibrated against real frames, and the obvious cheap checks were tried and
rejected first:

  * **Brightness / std / raw colour count do not work.** A death screen dims the world under a
    translucent red wash and measures brightness 99, std 45 — indistinguishable from healthy
    gameplay. Trusting those numbers is exactly how a 378 s recording of the death screen got
    reported as a successful render.
  * **"any UI slab present" does not work either.** `bands.py` reports one large slab for *every*
    frame, world frames included (1132x573 on a HUD'd render, and one on a bare render too), so
    `buttons > 0` rejects everything.

What does separate them, measured on four frames:

  | frame                 | dominant | quantised colours | menu-button-shaped slabs |
  |-----------------------|----------|-------------------|--------------------------|
  | death screen          | 0.35     | 21                | 1 (594x54)               |
  | loading terrain       | 0.66     | 12                | 0                        |
  | world, bare render    | 0.13     | 161               | 0                        |
  | world, HUD composited | 0.25     | 226               | 0                        |

So: a *stock menu button* is ~600x40 at GUI scale 3 and nothing in a world view has that shape,
while flat screens collapse into very few quantised colours. Colour count separates world from flat
by an 8x margin (161 against 21/12), which is why the threshold sits far from both.
"""
import re
import subprocess
import sys
from pathlib import Path

import numpy as np
from PIL import Image

DOMINANT_MAX = 0.50    # a live world is never half one colour
COLOURS_MIN = 60       # quantised (//32); worlds measure 161-226, flat screens 12-21
BUTTON_W = (555, 625)  # a stock menu button is 200 px * GUI scale 3
BUTTON_H = (26, 74)


def menu_buttons(path):
    """Number of slabs shaped like a stock Minecraft menu button (Respawn, Title Screen, ...)."""
    here = Path(__file__).resolve().parent
    out = subprocess.run(["/usr/bin/python3", str(here / "bands.py"), str(path)],
                         capture_output=True, text=True).stdout
    n = 0
    for w, h in re.findall(r"size=(\d+)x(\d+)", out):
        w, h = int(w), int(h)
        if BUTTON_W[0] <= w <= BUTTON_W[1] and BUTTON_H[0] <= h <= BUTTON_H[1]:
            n += 1
    return n


def classify(path):
    """(state, dominant_share, n_quantised_colours, n_menu_buttons) for one frame."""
    a = np.asarray(Image.open(path).convert("RGB"))
    q = (a // 32).reshape(-1, 3)
    _, counts = np.unique(q, axis=0, return_counts=True)
    dominant = counts.max() / counts.sum()
    colours = len(counts)
    buttons = menu_buttons(path)

    if buttons > 0:
        state = "ui"
    elif dominant > DOMINANT_MAX or colours < COLOURS_MIN:
        state = "flat"
    else:
        state = "world"
    return state, dominant, colours, buttons


def main():
    state, dom, cols, btn = classify(sys.argv[1])
    print(f"{state} dominant={dom:.2f} colours={cols} menu_buttons={btn}")
    sys.exit(0 if state == "world" else 1)


if __name__ == "__main__":
    main()

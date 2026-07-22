#!/usr/bin/env python3
"""Render a scrolling 'falling notes' piano-roll from a MIDI, synced to its audio, into
one mp4. Notes fall toward a 'now' line; vertical position is a COMPRESSED, unlabeled
function of pitch (so exact pitch is not readable from video alone — that needs the
audio), while onset timing and polyphony (how many notes start together) are clear.

Usage: render_pianoroll.py <midi> <wav> <out_mp4> <ffmpeg> [fps] [minutes]
"""
import subprocess, sys
import numpy as np
from PIL import Image
import pretty_midi

MIDI, WAV, OUT, FF = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
FPS = int(sys.argv[5]) if len(sys.argv) > 5 else 15
W, H = 1280, 720
LOOKAHEAD = 4.0          # seconds of upcoming notes visible above the now-line
PXPS = (H*0.8) / LOOKAHEAD  # pixels per second of fall
NOWY = int(H*0.85)       # now-line y

pm = pretty_midi.PrettyMIDI(MIDI)
notes = []
for inst in pm.instruments:
    for n in inst.notes:
        notes.append((n.start, n.end, n.pitch))
notes.sort()
dur = pm.get_end_time()
pitches = [p for _,_,p in notes]
pmin, pmax = min(pitches), max(pitches)
def y_of(pitch, trel):
    # trel = seconds until this note reaches the now-line (>=0 above, <0 below)
    return int(NOWY - trel*PXPS)
def x_of(pitch):
    # compressed horizontal position by pitch, no labels/gridlines
    frac = (pitch - pmin) / max(1, (pmax - pmin))
    return int(W*0.12 + frac*W*0.76)

bg = np.array([12,12,20], np.uint8)
line = np.array([90,90,110], np.uint8)
barcol = np.array([90,150,230], np.uint8)
nowcol = np.array([230,180,90], np.uint8)
BW = 26

proc = subprocess.Popen([FF,"-y","-loglevel","error","-f","rawvideo","-pix_fmt","rgb24",
    "-s",f"{W}x{H}","-r",str(FPS),"-i","-","-i",WAV,
    "-c:v","libx264","-pix_fmt","yuv420p","-c:a","aac","-shortest",OUT], stdin=subprocess.PIPE)
nframes = int(dur*FPS)+FPS
for f in range(nframes):
    tau = f/FPS
    fr = np.empty((H,W,3),np.uint8); fr[:,:]=bg
    fr[NOWY:NOWY+2,:] = line
    for (s,e,p) in notes:
        trel = s - tau                     # time until onset
        if -1.0 <= trel <= LOOKAHEAD:
            y = y_of(p, trel); x = x_of(p)
            length = max(6, int((e-s)*PXPS))
            y0 = max(0, y-length); y1 = min(H-1, y)
            col = nowcol if abs(trel) < (0.5/FPS*2) else barcol
            fr[y0:y1, max(0,x-BW//2):min(W,x+BW//2)] = col
    proc.stdin.write(fr.tobytes())
proc.stdin.close(); proc.wait()
print(f"rendered {nframes} frames, dur~{dur:.0f}s -> {OUT}")

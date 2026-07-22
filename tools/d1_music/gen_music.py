#!/usr/bin/env python3
"""Deterministic procedural music generator for the D1 transcription task.
Builds a multi-track MIDI (melody + chords + bass) from a seed, synthesizes audio
(sine, clear fundamentals), and emits the note-event ground truth. One seed -> identical
MIDI, audio, and answer key, so video and GT can never drift.

Usage: gen_music.py --seed 7 --minutes 10 --out-prefix OUT
Writes OUT.wav, OUT.notes.json (GT), OUT.mid
"""
import argparse, json, random
import numpy as np
import pretty_midi

SR = 22050
# C major / A minor scale degrees across octaves (MIDI note numbers)
SCALE = [60,62,64,65,67,69,71]  # C D E F G A B (C4..B4)

def build(seed, minutes):
    rng = random.Random(seed)
    pm = pretty_midi.PrettyMIDI(initial_tempo=100)
    melody = pretty_midi.Instrument(program=0, name="melody")
    chords = pretty_midi.Instrument(program=0, name="chords")
    bass   = pretty_midi.Instrument(program=0, name="bass")
    beat = 0.5                      # seconds per beat (120-ish)
    total = minutes * 60
    t = 0.0
    notes = []                      # GT: {t, track, pitch}
    deg = 0
    while t < total:
        # melody: step around the scale, 1 note per beat, octave 5
        deg = max(0, min(len(SCALE)*2-1, deg + rng.choice([-2,-1,-1,1,1,2])))
        octv = 12 if deg >= len(SCALE) else 0
        mp = SCALE[deg % len(SCALE)] + 12 + octv
        dur = beat * rng.choice([1,1,2])
        melody.notes.append(pretty_midi.Note(velocity=100, pitch=mp, start=t, end=t+dur*0.95))
        notes.append({"t": round(t,2), "track": "melody", "pitch": mp})
        # chord every 2 beats (root triad in octave 4)
        if int(round(t/beat)) % 2 == 0:
            root = SCALE[rng.choice([0,3,4])]   # I, IV, V
            for iv in (0,4,7):
                cp = root + iv
                chords.notes.append(pretty_midi.Note(velocity=70, pitch=cp, start=t, end=t+beat*2*0.95))
                notes.append({"t": round(t,2), "track": "chord", "pitch": cp})   # log every sounding note
            # bass = root one octave down
            bass.notes.append(pretty_midi.Note(velocity=90, pitch=root-12, start=t, end=t+beat*2*0.95))
            notes.append({"t": round(t,2), "track": "bass", "pitch": root-12})
        t += dur
    pm.instruments += [melody, chords, bass]
    return pm, notes

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seed", type=int, default=7)
    ap.add_argument("--minutes", type=float, default=10)
    ap.add_argument("--out-prefix", required=True)
    a = ap.parse_args()
    pm, notes = build(a.seed, a.minutes)
    pm.write(a.out_prefix + ".mid")
    audio = pm.synthesize(fs=SR)                 # sine synthesis, clear pitch
    audio = (audio / (np.abs(audio).max()+1e-9) * 0.9 * 32767).astype(np.int16)
    import wave
    with wave.open(a.out_prefix + ".wav", "w") as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(SR); w.writeframes(audio.tobytes())
    json.dump({"n_notes": len(notes), "sr": SR, "notes": notes}, open(a.out_prefix+".notes.json","w"), indent=1)
    dur = len(audio)/SR
    print(f"seed={a.seed} notes={len(notes)} audio={dur/60:.1f}min ({dur:.0f}s)")

if __name__ == "__main__":
    main()

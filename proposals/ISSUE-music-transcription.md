# [Task Proposal] Music-transcription ledger (audio-visual)

**Family:** `agentic_vbench_understanding` · **task id:** `music-transcription-ledger-s7`

## Hard / long-horizon + fills the AUDIO gap
Every other understanding task is video-only. This is genuinely **audio-visual**: a ~10-min
scrolling piano-roll of a 2724-note multi-voice piece, WITH audio. Reconstruct the
note-event ledger (pitch + onset). Exact pitch is unreadable from the video (unlabelled,
compressed roll) → needs the AUDIO; onset timing + polyphony come from the VIDEO. 2724
notes over 10 min = long-horizon; single frame / one modality / guess all fail.

## Cognitive level: understanding (fuse audio pitch with video timing across the piece).
## Modalities: BOTH required — video (onset/polyphony), audio (exact pitch).

## Question → schema
> Reconstruct every note that sounds: its pitch and onset time.
```json
{ "notes": [ {"t": seconds or mm:ss, "pitch": MIDI int or name like C4} ] }
```
Pitch accepted as MIDI number or scientific name. Onset tolerance 0.4 s.

## Ground truth
- **source:** the source MIDI's note events (tools/d1_music/gen_music.py --seed 7). **tier:** machine-truth.
- **verification:** oracle = the MIDI notes → scorer 1.0 (MIDI numbers and pitch names both).
  Audio + video rendered from ONE MIDI at fixed fps → exact timeline, cannot drift.

## Scorer (deterministic)
F1 over notes; TP iff same pitch and |onset diff| ≤ 0.4 s. oracle=1.0, empty=0.0 (verified).

## Anti-shortcut (≤0.15)
- **video_only** (audio stripped) — roll is unlabelled/compressed → no exact pitch.
- **audio_only** — dense polyphony onset/count hard without the roll.
- **single_frame / no_media** — no sequence; random piece not recall-able.

## Input media: self-hosted HF mp4 with audio (H.264+AAC), SHA-pinned, 10:01, 720p.

## Difficulty: calibrate Codex/Antigravity/Claude to <0.10 over 50+ turns.

## Novel / reproducible
First audio-visual understanding task; fresh-rendered (zero dataset overlap). Regenerable
from seed: `tools/d1_music/` (procedural MIDI → sine synth + piano-roll render → ffmpeg mux).

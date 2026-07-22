# Music-Transcription Ledger Reconstruction

You are given one video at `/workspace/materials/game.mp4`: a ~10-minute scrolling
piano-roll of an instrumental piece, **with audio**. Each note is both heard (a clear
tone) and seen (a coloured bar falling toward the horizontal "now" line at the moment
it sounds). The vertical axis is not labelled and is compressed, so the video shows you
*when* notes start and *how many* start together, but the exact pitch must be read from
the **audio**.

Reconstruct the note-event ledger: for every note that sounds, report its pitch and the
time it starts. Use any tools in the image (for example `ffmpeg` and `ffprobe`) to seek
through and sample both the video frames and the audio track.

## What to submit

Write `/workspace/output/solution.json` in exactly this shape:

```json
{
  "notes": [
    {"t": "00:00.0", "pitch": "C5"},
    {"t": "0.5",     "pitch": 76},
    {"t": "1.0",     "pitch": "F3"}
  ]
}
```

- One entry per note (chords have several notes at the same time).
- `t`: the note's onset time from the start of the video, in seconds (e.g. `12.5`) or
  `mm:ss` / `mm:ss.s`.
- `pitch`: either a MIDI note number (e.g. `60`) or a scientific pitch name (e.g. `C4`,
  `F#5`, `Bb3`). Middle C is `C4` = MIDI `60`.

## Rules

- Stay inside this working directory. Do not read, write, or search outside it.
- Do not look anything up online. The piece is not a known work; transcribe it from the
  video and audio.
- Report every note you can identify. Chords count as multiple simultaneous notes.

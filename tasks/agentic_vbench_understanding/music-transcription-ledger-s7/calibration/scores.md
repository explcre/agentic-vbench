# Calibration — music-transcription-ledger-s7

Deterministic F1 scorer (`steps/solve/tests/judge.py`): TP iff pitch matches and onset
within 0.4 s; F1 over notes. Clears the bar when every real agent scores <0.10 over 50+
tool-call turns. Oracle 1.0, empty near 0.

Ground truth: source MIDI note events (seed 7) — **2724 notes** (melody + chords + bass)
over 10:01, audio-visual piano-roll (720p H.264 + AAC).

| run | score | notes |
|---|---|---|
| oracle (MIDI numbers) | 1.0 | verified locally |
| oracle (pitch names) | 1.0 | name parser verified |
| empty / null | 0.0 | verified locally |
| all onsets +1.0 s | 0.26 | timing matters |
| all pitches +12 (wrong octave) | 0.20 | pitch matters |
| first-half correct | 0.67 | |
| Codex (GPT 5.6 Sol) | _to run_ | |
| Antigravity (Gemini 3.x) | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | |

## Ablations (each must be <= 0.15)
| ablation | score | notes |
|---|---|---|
| video_only (audio stripped) | _to run_ | pitch unreadable from the unlabelled/compressed roll -> expect low |
| audio_only | _to run_ | dense polyphony onset/count hard w/o the roll -> expect low |
| single_frame | _to run_ | one frame gives no sequence |
| no_media | _to run_ | random piece, not recall-able |

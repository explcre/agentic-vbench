# D1 — Music-transcription ledger: build tools

1. `gen_music.py --seed S --minutes 10 --out-prefix OUT` — procedural multi-voice MIDI +
   sine-synth audio (OUT.wav) + note-event ground truth (OUT.notes.json) + OUT.mid.
2. `render_pianoroll.py OUT.mid OUT.wav game.mp4 <ffmpeg> [fps]` — scrolling falling-notes
   piano-roll (pitch = unlabelled/compressed horizontal position, so exact pitch is NOT
   readable from video — that needs the audio), muxed with the audio at a fixed fps.
3. GT/oracle: notes.json -> ground_truth.json {notes:[{t,pitch}]} + solve.sh.

Audio-visual by design; scoring is F1 over (pitch, onset±0.4s). Uses pretty_midi + numpy
+ ffmpeg (no GL). `pip install pretty_midi`.

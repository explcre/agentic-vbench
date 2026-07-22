---
title: Task Spec Card
summary: music-transcription-ledger-s7 — audio-visual note-event transcription from a piano-roll video.
---

# Task Spec Card

```yaml
task: agentic_vbench_understanding/music-transcription-ledger-s7

cognitive_level: understanding
# Integrate pitch (audio) with onset/polyphony (video) across ~2700 notes over 10 min.

modalities_required:
  video: onset timing and polyphony (how many notes start together) — the roll is
         unlabelled/compressed so it does NOT give exact pitch.
  audio: exact pitch (clear-fundamental tones) — the video cannot supply it.

question: Reconstruct the note-event ledger — pitch + onset time for every note that sounds.
output_schema: '{"notes": [{"t": seconds or mm:ss, "pitch": MIDI int or name like C4}]}'

evidence:
  - "~2724 notes across 10:01, each a heard tone + a falling bar"
  - "exact pitch requires the audio; onset/polyphony requires the video"

ground_truth:
  source: source MIDI note events (tools/d1_music/gen_music.py --seed 7).
  tier: machine-truth
  verification: >
    Oracle solution.json is the MIDI's notes; judge.py scores it 1.0 (MIDI ints and
    pitch names both accepted). Audio, video, and GT all derive from one seeded MIDI
    rendered at a fixed frame rate, so the timeline is exact.

scorer:
  metric: "F1 over notes; TP iff same pitch and |onset diff| <= 0.4 s."
  oracle_reward: 1.0
  null_reward: 0.0

difficulty: {strong_agent_reward: TBD, tool_call_turns: TBD, agent_model: TBD}

anti_shortcut:
  video_only: TBD   # roll is unlabelled/compressed -> no exact pitch -> expect low
  audio_only: TBD   # dense polyphony onset/count hard without the roll -> expect low
  single_frame: TBD
  no_media: TBD

input:
  url: HF dataset (to upload): understanding-materials/music-transcription-ledger-s7/game.mp4
  sha256: see environment/Dockerfile
  length_min: 10.0
  resolution: 720
```

## Notes

- **Fills the audio gap.** Every other AVB understanding task is video-only; this one is
  genuinely audio-visual and requires fusing the two streams.
- **Fresh-rendered, machine-exact GT, exact timeline.** Audio + piano-roll are both
  rendered from one seeded MIDI at a fixed frame rate, so onset times are exact (no
  variable-FPS issue) and there is zero dataset overlap.
- **Multimodal by design.** Pitch is deliberately unreadable from the video (no axis
  labels, compressed vertical range) so audio is required; onset/polyphony structure in
  the roll is required to segment dense chords the audio alone cannot separate.

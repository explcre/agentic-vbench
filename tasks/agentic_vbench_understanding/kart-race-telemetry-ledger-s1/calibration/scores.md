# Calibration — kart-race-telemetry-ledger-s1

Rank agreement (Kendall tau) over four fields per kart:
`reward = 0.45·tau(finish) + 0.15·tau(start) + 0.25·tau(items) + 0.15·tau(nitro)`,
averaged over 4 races. GT = SuperTuxKart profile-mode result table (SuperTux difficulty AI,
6 karts × 4 tracks × 4 laps, 14.6 min, 720p).

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified through harness path (solve.sh → judge.py), all 4 races tau=1.0 |
| empty | 0.0 | verified |
| blind guess (all 4 fields random) | 0.16 | 500 trials, p95 0.26 |
| grid-only (read start grid, guess finish=grid) | 0.22 | honest partial credit (see SPEC) |
| podium-only (top-3 finish right) | 0.36 | partial credit is meaningful |
| Codex (GPT-5.6) | _running_ | ChatGPT Pro; harness in tools-side calib_kart/ |
| Antigravity (Gemini-3) | _to run_ | |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | |

Raw agent trajectories saved under `rollouts/` once each harness completes.

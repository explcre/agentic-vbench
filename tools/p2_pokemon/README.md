# P2 — Pokémon Showdown Bo3 move-ledger: build tools

Pipeline (Node + Python + Playwright/Chromium + ffmpeg):
1. `gen_series.js <seed> <out>` — pokemon-showdown random Bo3; writes game{1,2,3}.log + series.json (teams + GT move ledger).
2. `build_p2_task.py series.json <task_dir> vocab.md` — emits verifier ground_truth.json, oracle solve.sh, and the moveset vocabulary block.
3. `render_series.py <dir> <out.mp4> <ffmpeg> Fast` — captures each game's replay (move-name text hidden) via headless Chromium; turn-counter end-detection; GAME n title cards.
4. `repackage_series.py <dir> <out.mp4> <ffmpeg>` — crop battle to 16:9/720p, 1.2x slowdown to clear the 10-min floor, concat.

Setup: `npm install pokemon-showdown` and `python -m playwright install chromium`.

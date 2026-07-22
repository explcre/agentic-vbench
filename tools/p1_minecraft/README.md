# P1 — Minecraft build/mine ordered-ledger: build tools

Pipeline (Paper server + mineflayer + prismarine-viewer + Playwright + ffmpeg):
1. Start Paper 1.16.5 server (Java 11; eula.txt='eula=true'; ops.json for the bot via offline UUID).
2. `bot_build_full.js <out.json> <GO> <DONE> <STEP_MS>` — bot resets the area, waits for GO,
   lays a flat 8x9 mosaic of 11 distinct block types on the ground then mines 8 back to grass,
   one /setblock per STEP_MS. The command order is the machine-exact ground truth.
3. `capture_mc.py <outdir> <GO> <DONE> <max_s>` — Playwright (swiftshader) records the
   prismarine-viewer page, writes GO to start the build, waits for DONE.
4. Crop the mosaic region + scale to 720p (ffmpeg) → deliverable game.mp4.
5. `build_ordered_gt.py session.json <task_dir>` — emit ordered GT + oracle.

Note: the render is variable-FPS (software GL), so scoring is ORDER-based (LCS F1), not
timestamped — see the task judge.py. Launch server/bot/capture as detached processes.

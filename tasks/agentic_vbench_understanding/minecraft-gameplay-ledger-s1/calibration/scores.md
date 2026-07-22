# Calibration — minecraft-gameplay-ledger-s1 (v6: balanced high-diversity gameplay)

Order-aware LCS-F1 over (action, target) tokens. GT = the bot's mine/kill/place action
order (mineflayer-pathfinder: chop trees, gather varied blocks, hunt ~10 mob types, build).
54 events, **17 distinct tokens (max token 16.7%)**, first-person, 10:09, 720p.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| degenerate all-"mine oak_log" | 0.17 | vs 0.44 (v4) / 0.29 (v5) — much less guessable |
| correct multiset, shuffled | 0.41 | vs 0.62 (v4) / 0.45 (v5) — order matters more |
| Codex (GPT 5.6) | _to run_ | codex CLI installed; needs OPENAI_API_KEY |
| Antigravity (Gemini 3.x) | _to run_ | agy access TBD |
| Claude Code (Fable 5 / Opus 4.8) | _to run_ | installed; can run anytime |

10 mob types killed (cow, pig, sheep, chicken, rabbit, mooshroom, wolf, ocelot, fox,
llama) + 6 block types + build. Ablations (single_frame/no_media/frame_dump) to run; no
HUD/minimap in the render. Residual: block-mining repetition (6 types) keeps shuffled
~0.4; further gains would need lower per-block counts / more block types (multi-biome).

# Calibration — minecraft-gameplay-ledger-s1

Order-aware LCS-F1 scorer over (action, target) tokens. Oracle 1.0, empty near 0.
GT = bot's own mine/kill action order, 91 events (90 mine of 6 block types + 1 kill),
first-person, ~10:01.

| run | score | notes |
|---|---|---|
| oracle | 1.0 | verified |
| empty | 0.0 | verified |
| correct multiset, shuffled | 0.56 | see NOTE: low block-type diversity weakens order signal |
| degenerate all-"mine dirt" | 0.36 | known-answer exploit (needs GT distribution; blind agent can't) |
| Codex / Antigravity / Claude | _to run_ | |

NOTE (verifier strength): natural mining yields few, repeated block types, so LCS partly
measures the block multiset rather than strict order. To harden (make it clearly <0.10
for agents and order-sensitive), increase block-type diversity — a scripted varied
session across biomes/materials, or a richer action vocabulary (craft/place/open/eat).
Tracked as a follow-up; ablations (single_frame/no_media/frame_dump) still to run.

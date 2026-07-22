# Raw rollouts
One full raw trajectory per harness (not summaries). Save with:
```
claude -p "$(cat ../../steps/solve/instruction.md)" --verbose --output-format stream-json > claude.jsonl
codex exec --json "$(cat ../../steps/solve/instruction.md)" > codex.jsonl
agy -p "$(cat ../../steps/solve/instruction.md)" --model gemini-3.5-flash --log-file antigravity.log
```

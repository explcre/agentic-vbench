# Raw rollouts

One full raw trajectory per harness (not summaries), so scores can be audited and
tool-call turns counted. Save with the commands from the community guide:

```
claude -p "$(cat ../../steps/solve/instruction.md)" --verbose \
  --output-format stream-json > claude.jsonl
codex exec --json "$(cat ../../steps/solve/instruction.md)" > codex.jsonl
agy -p "$(cat ../../steps/solve/instruction.md)" --model gemini-3.5-flash \
  --log-file antigravity.log
```

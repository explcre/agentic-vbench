FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# The agent uses ffmpeg/ffprobe to seek and sample frames. The grader is pure
# stdlib (it only compares integers and times), so it needs nothing extra.

# Bake the rendered animation at build time with a pinned URL and a SHA256 verified
# at build, the same way the sports/assembly families do.
#
# TODO before this is a real task:
#   1. Upload the rendered clip (tools/gen_sortviz.py --seed 7 --n 80 ...) to the
#      agentic-vbench Hugging Face dataset and set the exact file URL below.
#   2. Set MATERIALS_SHA256 to the sha256 printed by the generator run (game.sha256).
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/sortviz-heapsort-swap-ledger-s7/game.mp4
ARG MATERIALS_SHA256=a86ff590e3a590af45c3d6f37b3314808911b0d4df078912a58ed8a57f245037
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 \
      "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - \
 && test -s /baked/game.mp4

WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

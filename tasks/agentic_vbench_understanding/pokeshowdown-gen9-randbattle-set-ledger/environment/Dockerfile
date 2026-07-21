FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
# TODO before this is a real task: render the 5 frozen battle logs into one muted mp4
# (text log panel hidden), upload to the agentic-vbench HF dataset, set URL + SHA256.
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/pokeshowdown-gen9-randbattle-set-ledger/game.mp4
ARG MATERIALS_SHA256=REPLACE_AFTER_RENDER
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 \
      "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - \
 && test -s /baked/game.mp4
WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

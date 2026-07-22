FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/game.mp4
ARG MATERIALS_SHA256=8c00eec5d065b73ed0678c13ad13b57268715b1cbd8ef490ab98ebb2e1735890
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - && test -s /baked/game.mp4
WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

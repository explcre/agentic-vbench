FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ARG MATERIALS_URL=https://huggingface.co/datasets/explcre/agenticvbench-understanding-materials/resolve/main/minecraft-gameplay-ledger-s1/game.mp4
ARG MATERIALS_SHA256=3a13a316c8102189a57290d748629a2a9ba5c3bc9754100fc3648092cf330e52
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - && test -s /baked/game.mp4
WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

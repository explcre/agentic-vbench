FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# The agent uses ffmpeg/ffprobe to seek and sample frames. Grader is pure stdlib.

# Bake the rendered Bo3 series at build time with a pinned URL + SHA256.
# TODO before real: upload rendered game.mp4 to the agentic-vbench HF dataset and set
# MATERIALS_URL; set MATERIALS_SHA256 to the generator's printed sha256.
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/pokemon-showdown-bo3-move-ledger-s7/game.mp4
ARG MATERIALS_SHA256=f1fb3cbb6f9ef21feb10f039c76a7c886bb146f57ddf35c999944947ac7f4345
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 \
      "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - \
 && test -s /baked/game.mp4

WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

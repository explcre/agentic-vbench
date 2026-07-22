FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
# TODO: upload rendered game.mp4 to HF, set URL + SHA256 below.
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/minecraft-build-mine-ledger-s1/game.mp4
ARG MATERIALS_SHA256=d541b27c973d20f6d0c7726eb98fefed79502f62dd6fcffc21abf089a1b246a7
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - && test -s /baked/game.mp4
WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

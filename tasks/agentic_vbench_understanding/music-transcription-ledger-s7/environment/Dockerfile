FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
# The agent needs ffmpeg/ffprobe to sample video frames AND extract the audio track.
# TODO: upload rendered game.mp4 (with audio) to HF, set URL + SHA256.
ARG MATERIALS_URL=https://huggingface.co/datasets/agentic-vbench/understanding-materials/resolve/main/music-transcription-ledger-s7/game.mp4
ARG MATERIALS_SHA256=62847e74691c9bfab80e675eebe87aeb4ca7085393e11ecd6487d0c015cc1be1
RUN mkdir -p /baked \
 && curl --fail --silent --show-error --location --retry 5 --retry-delay 3 "$MATERIALS_URL" -o /baked/game.mp4 \
 && echo "${MATERIALS_SHA256}  /baked/game.mp4" | sha256sum -c - && test -s /baked/game.mp4
WORKDIR /workspace
RUN mkdir -p /workspace/materials /workspace/output /workspace/work

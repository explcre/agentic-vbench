#!/bin/bash
# Record an AUTHENTIC Minecraft session: the real 1.20.4 client renders the world while the same
# mineflayer bot that drives the headless path plays in it, with the client locked to the bot's
# point of view by /spectate. Nothing is composited — cracks, hurt flashes, hand swing, particles
# and sound are the game's own.
#
#   authentic_session.sh OUTDIR [PHASES]
#
# Why this shape (each point cost a failed attempt):
#   * 1.20.4, not 1.16.5 — `--server` never auto-connected in 1.16.5; quickPlay arrived in 1.20.
#   * options.txt with onboardAccessibility:false — the 1.20 first-launch accessibility screen
#     blocks quickPlay, and it was the reason the client sat on a four-button dialog.
#   * JDK 21 from $HOME — 1.20 needs Java 17+, this host only has 8 and 11.
#   * NO_VIEWER=1 — the bot's own prismarine-viewer is pointless here and just burns CPU.
#   * the port is checked before launch, because a stale server silently ate an earlier run.
#   * ops.json is written BEFORE the server starts. A fresh Paper server has `ops: []`, and an
#     unprivileged player gets *"Unknown command"* for /setblock, /summon and /locate -- Brigadier
#     hides commands you may not run. That looks exactly like a version incompatibility and cost a
#     whole session (0 events recorded) before `probe_1204.js` isolated it.
set -eux
OUT=${1:?outdir}
PHASES=${2:-start,forest,build_village}
MC=/tmp/galaxy_srv_disk00/pengchx3/agenticvbench/mc-client-1204
SRV=/tmp/galaxy_srv_disk00/pengchx3/agenticvbench/p1-mc-server-1204
TOOLS=/home/pengchx3/text-dna/agenticvbench-claude/tools/p1_minecraft
J=$HOME/jdk-21.0.11+10/bin/java
PORT=25590
mkdir -p "$OUT"
FF=${FFMPEG:-$(/usr/bin/python3 -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())" 2>/dev/null || echo ffmpeg)}

[ -s "$MC/bin/client.jar" ] || { echo "PREFLIGHT_FAIL no 1.20.4 client"; exit 3; }
[ -x "$J" ]                 || { echo "PREFLIGHT_FAIL no JDK 21";       exit 3; }
grep -q onboardAccessibility "$MC/options.txt" || { echo "PREFLIGHT_FAIL options.txt missing the onboarding opt-out"; exit 3; }
/usr/bin/python3 "$TOOLS/make_ops.py" "$SRV" Builder Camera Director
grep -q '"name": "Builder"' "$SRV/ops.json" || { echo "PREFLIGHT_FAIL Builder not op'd"; exit 3; }

# Kill ONLY a stale server for THIS world. Both the 1.16.5 and 1.20.4 servers have the identical
# command line (`java -jar paper.jar nogui`), so match on the process's cwd -- a blanket
# `grep paper.jar | kill` would take down the headless render running in parallel.
for pid in $(ps -u "$USER" -o pid,cmd | grep 'paper.jar' | grep -v grep | awk '{print $1}'); do
  [ "$(readlink -f /proc/$pid/cwd 2>/dev/null)" = "$(readlink -f "$SRV")" ] && kill $pid || true
done
sleep 4
for n in $(seq 60 79); do [ ! -e /tmp/.X${n}-lock ] && D=$n && break; done
: "${D:?no free X display}"
Xvfb :$D -screen 0 1280x720x24 -nolisten tcp & XVFB=$!
sleep 3

rm -f "$SRV"/world*/session.lock
(cd "$SRV" && "$J" -Xmx3G -jar paper.jar nogui > "$OUT/server.log" 2>&1) & SRVPID=$!
for i in $(seq 1 90); do grep -q 'Done (' "$OUT/server.log" && break; sleep 2; done
(exec 3<>/dev/tcp/127.0.0.1/$PORT) 2>/dev/null || { echo "SERVER_NOT_LISTENING"; kill $SRVPID $XVFB; exit 4; }
echo SERVER_READY

# the gameplay bot — same file as the headless path, different version/port, viewer off
cd "$TOOLS"
MC_VERSION=1.20.4 MC_PORT=$PORT NO_VIEWER=1 P1_PHASES="$PHASES" \
  node bot_play8.js "$OUT/play.json" "$OUT/GO" "$OUT/DONE" > "$OUT/bot.log" 2>&1 & BOT=$!
for i in $(seq 1 40); do grep -qi 'Builder joined' "$OUT/server.log" && break; sleep 2; done
grep -qi 'Builder joined' "$OUT/server.log" || { echo "BOT_NEVER_JOINED"; tail -5 "$OUT/bot.log"; kill $BOT $SRVPID $XVFB; exit 5; }
echo BOT_JOINED

CP=$(cat "$MC/classpath.txt"); AIDX=$(cut -d= -f2 "$MC/asset_index.txt")
DISPLAY=:$D LIBGL_ALWAYS_SOFTWARE=1 GALLIUM_DRIVER=llvmpipe MESA_GL_VERSION_OVERRIDE=3.3 \
  "$J" -Xmx3G -cp "$CP" -Djava.library.path="$MC/natives" net.minecraft.client.main.Main \
  --username Camera --version 1.20.4 --gameDir "$MC" --assetsDir "$MC/assets" --assetIndex "$AIDX" \
  --uuid 00000000000000000000000000000001 --accessToken 0 --userType legacy \
  --width 1280 --height 720 --quickPlayMultiplayer 127.0.0.1:$PORT > "$OUT/client.log" 2>&1 & CLIENT=$!
for i in $(seq 1 75); do grep -qi 'Camera joined' "$OUT/server.log" && break; sleep 4; done
grep -qi 'Camera joined' "$OUT/server.log" || { echo "CLIENT_NEVER_JOINED"; tail -10 "$OUT/client.log"; kill $CLIENT $BOT $SRVPID $XVFB; exit 6; }
echo CLIENT_JOINED

# lock the camera to the bot, server-side (no client input at all)
node -e '
const mineflayer=require("mineflayer");
const b=mineflayer.createBot({host:"localhost",port:'"$PORT"',username:"Director",version:"1.20.4",auth:"offline"});
b.once("spawn",async()=>{const s=ms=>new Promise(r=>setTimeout(r,ms));
  b.chat("/op Camera"); await s(700);
  b.chat("/time set day"); await s(400); b.chat("/weather clear"); await s(400);
  b.chat("/gamemode spectator Camera"); await s(700);
  b.chat("/spectate Builder Camera"); await s(700);
  console.log("SPECTATE_LOCKED"); process.exit(0);});
b.on("error",e=>{console.log("DIRECTOR_ERR",e.message);process.exit(1);});' >> "$OUT/director.log" 2>&1 || true
tail -1 "$OUT/director.log"

sleep 25                                   # let chunks mesh before recording
DISPLAY=:$D "$FF" -v error -f x11grab -framerate 15 -video_size 1280x720 -i :$D \
  -c:v libx264 -preset veryfast -crf 23 -pix_fmt yuv420p "$OUT/authentic.mp4" -y & CAP=$!
sleep 2
touch "$OUT/GO"                            # start the session

for i in $(seq 1 450); do [ -f "$OUT/DONE" ] && break; sleep 4; done
sleep 4
kill -INT $CAP 2>/dev/null || true; wait $CAP 2>/dev/null || true
kill $CLIENT $BOT 2>/dev/null || true; sleep 2; kill $SRVPID $XVFB 2>/dev/null || true

if grep -q 'biome-miss\|mob-miss' "$OUT/bot.log" "$OUT/play.json.crash.log" 2>/dev/null; then
  echo "WARN world commands are being refused — check ops.json"; fi

if [ -s "$OUT/authentic.mp4" ]; then
  DUR=$("${FFPROBE:-/pkg/ffmpeg/4.2.2/bin/ffprobe}" -v error -show_entries format=duration -of csv=p=0 "$OUT/authentic.mp4")
  N=$(/usr/bin/python3 -c "import json;print(len(json.load(open('$OUT/play.json'))['events']))" 2>/dev/null || echo 0)
  echo "AUTHENTIC_OK ${DUR}s ${N}_events"
else
  echo NO_VIDEO_RECORDED
fi

#!/bin/bash
set -e

LOG_FILE="/tmp/floorp.log"
DISPLAY_NUM=":99"

echo "🛠 Stopping any existing Xvfb and VNC instances..." | tee -a "$LOG_FILE"
pkill -9 Xvfb || true
pkill -9 x11vnc || true
pkill -9 floorp || true

echo "🛠 Removing old X lock files..." | tee -a "$LOG_FILE"
rm -rf /tmp/.X*-lock /tmp/.X11-unix

echo "🛠 Waiting 3 seconds to ensure processes are fully stopped..." | tee -a "$LOG_FILE"
sleep 3

echo "🛠 Starting Xvfb..." | tee -a "$LOG_FILE"
Xvfb $DISPLAY_NUM -screen 0 1280x720x24 &

# Wait for Xvfb to be ready
sleep 2

if ! pgrep Xvfb > /dev/null; then
    echo "❌ Xvfb failed to start. Exiting." | tee -a "$LOG_FILE"
    exit 1
fi

export DISPLAY=$DISPLAY_NUM

echo "🔧 Starting VNC server..." | tee -a "$LOG_FILE"
x11vnc -display :99 -nopw -forever &

sleep 2

if ! pgrep x11vnc > /dev/null; then
    echo "❌ x11vnc failed to start. Exiting." | tee -a "$LOG_FILE"
    exit 1
fi

echo "🔧 Starting noVNC..." | tee -a "$LOG_FILE"
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

echo "✅ Floorp optimizations applied!"

echo "🔥 Launching Floorp..." | tee -a "$LOG_FILE"
exec floorp --no-remote --new-instance --disable-gpu --disable-software-rasterizer --profile /home/floorpuser/.floorp/default-release 2>&1 | tee -a "$LOG_FILE"

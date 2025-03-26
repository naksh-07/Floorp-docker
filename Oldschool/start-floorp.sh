#!/bin/bash
set -e

LOG_FILE="/tmp/floorp.log"
DISPLAY_NUM=":99"

echo "🛠 Stopping any existing Xvfb and VNC instances..." | tee -a "$LOG_FILE"
pkill -9 Xvfb || true  # Force kill any running Xvfb
pkill -9 x11vnc || true  # Kill any running VNC process
pkill -9 floorp || true  # Kill any old Floorp process

echo "🛠 Removing old X lock files..." | tee -a "$LOG_FILE"
rm -rf /tmp/.X*-lock /tmp/.X11-unix

echo "🛠 Waiting 3 seconds to ensure processes are fully stopped..." | tee -a "$LOG_FILE"
sleep 3  # Wait a bit to make sure old processes have exited

echo "🛠 Starting Xvfb..." | tee -a "$LOG_FILE"
Xvfb $DISPLAY_NUM -screen 0 1280x720x24 &

# Wait for Xvfb to be ready
sleep 2

# Check if Xvfb is actually running before continuing
if ! pgrep Xvfb > /dev/null; then
    echo "❌ Xvfb failed to start. Exiting." | tee -a "$LOG_FILE"
    exit 1
fi

export DISPLAY=$DISPLAY_NUM

# Start VNC server
echo "🔧 Starting VNC server on display :99..." | tee -a "$LOG_FILE"
x11vnc -display :99 -nopw -forever &

# Wait for x11vnc to start properly
sleep 2

# Check if x11vnc started successfully
if ! pgrep x11vnc > /dev/null; then
    echo "❌ x11vnc failed to start. Exiting." | tee -a "$LOG_FILE"
    exit 1
fi

# Start noVNC WebSockets proxy
echo "🔧 Starting noVNC on port 6080..." | tee -a "$LOG_FILE"
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

# Apply Floorp Optimizations 🔥
echo "🚀 Applying Floorp optimizations..." | tee -a "$LOG_FILE"

FLOORP_PREFS="/home/floorpuser/.floorp/default-release/user.js"
mkdir -p /home/floorpuser/.floorp/default-release/

cat <<EOF > $FLOORP_PREFS
// Disable Telemetry & Background Services
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

// Limit RAM Usage to 2GB
user_pref("dom.ipc.processCount", 1);
user_pref("dom.ipc.processCount.web", 1);
user_pref("browser.cache.memory.capacity", 524288);
user_pref("image.mem.max_decoded_image_kb", 102400);
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.tabs.unload.threshold_low_memory", 2000000000); // 2GB Limit

// Reduce Media Buffering to Save RAM
user_pref("media.memory_cache_max_size", 65536);
user_pref("media.cache_readahead_limit", 30);
user_pref("media.cache_resume_threshold", 15);

// Reduce CPU Usage for Rendering
user_pref("gfx.webrender.all", false);
user_pref("gfx.canvas.accelerated", false);
user_pref("media.hardware-video-decoding.enabled", false);

// Optimize JavaScript Execution
user_pref("javascript.options.baselinejit", true);
user_pref("javascript.options.ion", false);
EOF

echo "✅ Floorp optimizations applied!"

# Launch Floorp (Stable Mode, 2GB RAM Allowed)
echo "🔥 Launching Floorp..." | tee -a "$LOG_FILE"
exec floorp --no-remote --new-instance --disable-gpu --disable-software-rasterizer --profile /home/floorpuser/.floorp/default-release 2>&1 | tee -a "$LOG_FILE"

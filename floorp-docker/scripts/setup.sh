#!/bin/bash
set -e

echo "🛠 Installing dependencies..."
apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    dbus-x11 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libxcb-randr0 \
    sqlite3 \
    curl \
    gpg \
    ca-certificates \
    x11vnc \
    websockify \
    git \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

echo "🛠 Installing Floorp..."
curl -fsSL https://ppa.floorp.app/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list "https://ppa.floorp.app/Floorp.list"
apt update && apt install -y floorp
apt-get clean && rm -rf /var/lib/apt/lists/*

echo "🛠 Installing noVNC..."
mkdir -p /opt/novnc
git clone --depth=1 https://github.com/novnc/noVNC.git /opt/novnc
git clone --depth=1 https://github.com/novnc/websockify.git /opt/novnc/utils/websockify
chmod +x /opt/novnc/utils/novnc_proxy

echo "🛠 Creating user floorpuser..."
useradd -m -s /bin/bash floorpuser

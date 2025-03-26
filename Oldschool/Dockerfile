# Use a minimal Debian image
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
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

# Install Floorp browser
RUN curl -fsSL https://ppa.floorp.app/KEY.gpg | gpg --dearmor -o /usr/share/keyrings/Floorp.gpg && \
    curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list "https://ppa.floorp.app/Floorp.list" && \
    apt update && apt install -y floorp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc && \
    git clone --depth=1 https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone --depth=1 https://github.com/novnc/websockify.git /opt/novnc/utils/websockify && \
    chmod +x /opt/novnc/utils/novnc_proxy

# Create non-root user
RUN useradd -m -s /bin/bash floorpuser

# Set up environment
ENV DISPLAY=:99

# Copy startup script
COPY start-floorp.sh /usr/local/bin/start-floorp.sh
RUN chmod +x /usr/local/bin/start-floorp.sh

# Expose the VNC port for noVNC
EXPOSE 6080

# Set working directory
WORKDIR /home/floorpuser

# Switch to non-root user
USER floorpuser

# Entrypoint
ENTRYPOINT ["/usr/local/bin/start-floorp.sh"]

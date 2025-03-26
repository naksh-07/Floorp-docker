# Use a minimal Debian image
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Copy setup script before running it
COPY scripts/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh && /tmp/setup.sh

# Copy optimized Floorp settings
COPY config/user.js /home/floorpuser/.floorp/default-release/user.js
RUN chown -R floorpuser:floorpuser /home/floorpuser/.floorp

# Copy startup script
COPY start-floorp.sh /usr/local/bin/start-floorp.sh
RUN chmod +x /usr/local/bin/start-floorp.sh

# Set working directory
WORKDIR /home/floorpuser

# Expose the VNC port for noVNC
EXPOSE 6080

# Switch to non-root user
USER floorpuser

# Entrypoint
ENTRYPOINT ["/usr/local/bin/start-floorp.sh"]

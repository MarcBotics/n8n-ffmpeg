ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Fix permissions issue and find n8n location
RUN find / -name "n8n" -type f -executable 2>/dev/null || true
RUN which node || true
RUN echo $PATH

# Set environment variable for permissions
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Switch back to node user
USER node

# Use the original image's default command

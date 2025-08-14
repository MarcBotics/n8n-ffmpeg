ARG N8N_VERSION=1.6.0
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Create a symlink for /bin/sh to /bin/ash to handle potential hardcoded shell calls
RUN ln -sf /bin/ash /bin/sh

RUN N8N_PATH=$(find / -name "n8n" -type f -executable 2>/dev/null | grep -m 1 .) && \
    [ -n "$N8N_PATH" ] && echo "n8n found at: $N8N_PATH" && ln -sf "$N8N_PATH" /usr/local/bin/n8n || echo "n8n not found"
RUN which node || true
RUN echo $PATH

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Create the .n8n directory. Permissions will be handled by Railway's volume mounting.
RUN mkdir -p /home/node/.n8n

USER node

# Start n8n directly
ENTRYPOINT ["/usr/local/bin/n8n"]

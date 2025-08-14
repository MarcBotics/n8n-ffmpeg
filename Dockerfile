ARG N8N_VERSION=1.6.0
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

RUN N8N_PATH=$(find / -name "n8n" -type f -executable 2>/dev/null | grep -m 1 .) && \
    [ -n "$N8N_PATH" ] && echo "n8n found at: $N8N_PATH" && ln -sf "$N8N_PATH" /usr/local/bin/n8n || echo "n8n not found"
RUN which node || true
RUN echo $PATH

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Declare the volume for n8n data
VOLUME /home/node/.n8n

USER node

# Ensure correct permissions for the volume before starting n8n
ENTRYPOINT ["/bin/ash", "-c", "chown -R node:node /home/node/.n8n && /usr/local/bin/n8n"]

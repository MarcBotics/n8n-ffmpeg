ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Valideer en stel het n8n-pad expliciet in
RUN N8N_PATH=$(find / -name "n8n" -type f -executable 2>/dev/null | grep -m 1 .) && \
    [ -n "$N8N_PATH" ] && echo "n8n found at: $N8N_PATH" && ln -sf "$N8N_PATH" /usr/local/bin/n8n || echo "n8n not found"
RUN which node || true
RUN echo $PATH

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

USER node

# Robuuste ENTRYPOINT zonder CMD
ENTRYPOINT ["/usr/local/bin/n8n"]

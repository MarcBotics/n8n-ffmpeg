ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

# Find the n8n executable and set the correct path
RUN find / -name "n8n" -type f -executable 2>/dev/null | grep -m 1 . > /tmp/n8n_path
RUN N8N_PATH=$(cat /tmp/n8n_path) && [ -n "$N8N_PATH" ] && echo "n8n found at: $N8N_PATH" || echo "n8n not found"
RUN which node || true
RUN echo $PATH

# Set environment variable for permissions
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Switch back to node user
USER node

# Explicitly define ENTRYPOINT to start n8n
ENTRYPOINT ["/usr/local/bin/n8n"]
CMD [""]  # Empty CMD lets ENTRYPOINT run without arguments

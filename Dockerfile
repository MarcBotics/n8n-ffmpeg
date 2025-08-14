ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root
RUN apk update && apk add --no-cache \
    ffmpeg \
    curl \
    wget \
    && rm -rf /var/cache/apk/*

RUN find / -name "n8n" -type f -executable 2>/dev/null || true
RUN which node || true
RUN echo $PATH

ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

USER node

# Expliciet ENTRYPOINT en lege CMD om "start" te vermijden
ENTRYPOINT ["/usr/local/bin/n8n"]
CMD [""]  # Lege CMD voorkomt uitvoering van "start"

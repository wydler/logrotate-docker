# Reference image
FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# Metadata
LABEL maintainer="Daniel Wydler"
LABEL org.opencontainers.image.authors="Daniel Wydler"
LABEL org.opencontainers.image.description="Docker image for rotating log files from other containers."
LABEL org.opencontainers.image.documentation="https://github.com/wydler/logrotate-docker/blob/master/README.md"
LABEL org.opencontainers.image.source="https://github.com/wydler/logrotate-docker"
LABEL org.opencontainers.image.title="wydler/logrotate"
LABEL org.opencontainers.image.url="https://github.com/wydler/logrotate-docker"

# Install required packages
RUN apk upgrade --no-cache \
 && apk add --no-cache \
    logrotate \
    tzdata \
    bash \
    coreutils \
    findutils \
    grep

# Create directory for logs
RUN mkdir -p /logs

# Copy entrypoint script
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Set environment variables with default values
ENV LOGS_PATH="/logs/*.log" \
    TRIGGER_INTERVAL="daily" \
    MAX_SIZE="NONE" \
    MAX_BACKUPS="365" \
    TZ="UTC" \
    DELAYCOMPRESS="true"

# Set volume for logs
VOLUME /logs

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Default command
CMD ["run"]
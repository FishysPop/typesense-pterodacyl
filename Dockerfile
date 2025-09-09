# Typesense Dockerfile for Pterodactyl
# Based on Alpine Linux following Pterodactyl guidelines

FROM alpine:latest

MAINTAINER Pterodactyl Software, <support@pterodactyl.io>

# Install dependencies and create container user
RUN apk add --no-cache --update curl ca-certificates openssl bash \
    && adduser --disabled-password --home /home/container container

# Install Typesense
RUN apk add --no-cache libc6-compat libstdc++ libgcc \
    && curl -L -o /tmp/typesense.tar.gz https://dl.typesense.org/releases/30.0.rc11/typesense-server-30.0.rc11-amd64.tar.gz \
    && mkdir -p /opt/typesense \
    && tar -xzf /tmp/typesense.tar.gz -C /opt/typesense \
    && rm /tmp/typesense.tar.gz \
    && chmod +x /opt/typesense/typesense-server

# Switch to container user
USER container
ENV USER=container HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Define the startup command
CMD ["/bin/bash", "/entrypoint.sh"]
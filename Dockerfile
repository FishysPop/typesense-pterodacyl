# Typesense Dockerfile for Pterodactyl
# Based on the official Typesense image with Pterodactyl requirements

FROM typesense/typesense:30.0.rc11

MAINTAINER Pterodactyl Software, <support@pterodactyl.io>

# Install Pterodactyl requirements
RUN apt-get update && apt-get install -y curl ca-certificates openssl bash

# Create necessary directories
RUN mkdir -p /home/container/data /etc/typesense

# Set proper permissions
RUN chown -R typesense:typesense /home/container /etc/typesense || true

# Set environment variables
ENV USER=typesense HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Define the startup command
CMD ["/bin/bash", "/entrypoint.sh"]
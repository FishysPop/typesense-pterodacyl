# Typesense Dockerfile for Pterodactyl
# Based on the official Typesense image with Pterodactyl requirements

FROM typesense/typesense:0.30.0

# Install Pterodactyl requirements
RUN apt-get update && apt-get install -y curl ca-certificates openssl bash \
    && useradd --disabled-password --home /home/container container

# Create necessary directories
RUN mkdir -p /home/container/data /etc/typesense

# Copy configuration file
COPY typesense-server.ini /etc/typesense/typesense-server.ini

# Switch to container user
USER container
ENV USER=container HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Define the startup command
CMD ["/bin/bash", "/entrypoint.sh"]

# Switch to container user
USER container
ENV USER=container HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Define the startup command
CMD ["/bin/bash", "/entrypoint.sh"]
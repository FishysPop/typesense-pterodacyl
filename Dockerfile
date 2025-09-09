# Typesense Dockerfile for Pterodactyl
# Multi-architecture build from binary

FROM alpine:3.18

# Install dependencies
RUN apk add --no-cache --update curl ca-certificates openssl bash tar

# Detect architecture and install appropriate Typesense binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        TYPESSENSE_ARCH="amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then \
        TYPESSENSE_ARCH="arm64"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    echo "Installing Typesense for architecture: $TYPESSENSE_ARCH" && \
    curl -L -O https://dl.typesense.org/releases/29.0/typesense-server-29.0-linux-$TYPESSENSE_ARCH.tar.gz && \
    tar -xzf typesense-server-29.0-linux-$TYPESSENSE_ARCH.tar.gz && \
    mkdir -p /opt/typesense && \
    mv typesense-server /opt/typesense/ && \
    rm typesense-server-29.0-linux-$TYPESSENSE_ARCH.tar.gz && \
    chmod +x /opt/typesense/typesense-server

# Create container user
RUN adduser --disabled-password --home /home/container container

# Create necessary directories
RUN mkdir -p /home/container/data /etc/typesense

# Switch to container user
USER container
ENV USER=container HOME=/home/container

# Set working directory
WORKDIR /home/container

# Copy entrypoint and startup scripts
COPY ./entrypoint.sh /entrypoint.sh
COPY ./startup.sh /startup.sh

# Define the startup command
CMD ["/bin/bash", "/entrypoint.sh"]
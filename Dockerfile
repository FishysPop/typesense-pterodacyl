# Typesense Dockerfile for Pterodactyl
# Based on the official Typesense image

ARG TYPESENSE_VERSION=30.0.rc11
FROM typesense/typesense:${TYPESENSE_VERSION}

# Create necessary directories
RUN mkdir -p /home/container/data /etc/typesense

# Create a symlink for Pterodactyl compatibility
RUN ln -s /mnt/server/data /home/container/data || true

# Copy configuration file
COPY typesense-server.ini /etc/typesense/typesense-server.ini

# Set working directory
WORKDIR /home/container

# Expose the default Typesense port
EXPOSE 8108

# Define the startup command
CMD ["/opt/typesense/typesense-server", "--config=/etc/typesense/typesense-server.ini"]
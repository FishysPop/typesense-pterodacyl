# Typesense Dockerfile for Pterodactyl
# Based on the official Typesense image

FROM typesense/typesense:30.0

# Create necessary directories
RUN mkdir -p /home/container/data /etc/typesense

# Copy configuration file
COPY typesense-server.ini /etc/typesense/typesense-server.ini

# Set working directory
WORKDIR /home/container

# Expose the default Typesense port
EXPOSE 8108

# Define the startup command
CMD ["/opt/typesense/typesense-server", "--config=/etc/typesense/typesense-server.ini"]
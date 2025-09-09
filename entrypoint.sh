#!/bin/bash
cd /home/container

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p /mnt/server/data
chmod 777 /mnt/server/data

# Set proper ownership
chown -R typesense:typesense /mnt/server/data 2>/dev/null || true

# Output information
echo "Starting Typesense server..."

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
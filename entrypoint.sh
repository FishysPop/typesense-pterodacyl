#!/bin/bash
cd /home/container

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p /home/container/data
chmod 777 /home/container/data

# Set proper ownership
chown -R container:container /home/container/data 2>/dev/null || true

# Check if Typesense binary exists
if [ ! -f /opt/typesense/typesense-server ]; then
    echo "ERROR: Typesense binary not found at /opt/typesense/typesense-server"
    ls -la /opt/typesense/ 2>/dev/null || echo "ERROR: /opt/typesense/ directory does not exist"
    exit 1
fi

# Output information
echo "Starting Typesense server..."

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
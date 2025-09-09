#!/bin/bash
# Default Typesense startup script for Pterodactyl

# Check if Typesense binary exists
if [ ! -f /opt/typesense/typesense-server ]; then
    echo "ERROR: Typesense binary not found at /opt/typesense/typesense-server"
    echo "Listing /opt/typesense/:"
    ls -la /opt/typesense/ 2>/dev/null || echo "/opt/typesense/ directory does not exist"
    echo "Listing current directory:"
    ls -la
    exit 1
fi

# Create data directory if it doesn't exist
mkdir -p /home/container/data
chmod 777 /home/container/data

# Set default values if environment variables are not set
: ${TYPESENSE_API_KEY:="xyz"}
: ${TYPESENSE_ENABLE_CORS:="1"}
: ${SERVER_PORT:="8108"}

# Start Typesense server
/opt/typesense/typesense-server \
  --data-dir=/home/container/data \
  --api-key=${TYPESENSE_API_KEY} \
  --enable-cors=${TYPESENSE_ENABLE_CORS} \
  --port=${SERVER_PORT}
#!/bin/bash
cd /home/container

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p /mnt/server/data
chmod 777 /mnt/server/data

# Create config file if it doesn't exist
if [ ! -f /etc/typesense/typesense-server.ini ]; then
    echo "Creating configuration file..."
    mkdir -p /etc/typesense
    cat > /etc/typesense/typesense-server.ini << 'EOF'
[typesense]
port = {{SERVER_PORT}}
data-dir = /mnt/server/data
api-key = {{TYPESENSE_API_KEY}}
enable-cors = {{TYPESENSE_ENABLE_CORS}}
EOF
fi

# Output information
echo "Starting Typesense server..."

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
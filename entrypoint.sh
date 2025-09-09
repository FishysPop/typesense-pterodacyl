#!/bin/bash
cd /home/container

# Check if startup script exists
if [ ! -f /startup.sh ]; then
    echo "ERROR: /startup.sh not found!"
    ls -la /
    exit 1
fi

# Output information
echo "Starting Typesense server..."

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
#!/bin/bash
cd /home/container

# Internal environment variable for the startup command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')

# --- Performance Optimizations ---
# Set GOMEMLIMIT to 90% of allocated memory to prevent OOM
if [ ! -z "${SERVER_MEMORY}" ]; then
    export GOMEMLIMIT=$((SERVER_MEMORY * 90 / 100))MiB
fi

# Set GOMAXPROCS to respect CPU limits (if CPU limit is set)
# Note: Go 1.23+ handles this better, but we can be explicit
if [ ! -z "${SERVER_CPU}" ] && [ "${SERVER_CPU}" != "0" ]; then
    # Convert percentage to core count (minimal 1)
    export GOMAXPROCS=$(( (SERVER_CPU + 99) / 100 ))
fi

# Optimization for faster GC (optional, balance between RAM and CPU)
export GOGC=100

echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}

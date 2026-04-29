#!/bin/bash
cd /home/container

# Internal environment variable for the startup command
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')

# --- Performance Optimizations ---
if [ ! -z "${SERVER_MEMORY}" ]; then
    export GOMEMLIMIT=$((SERVER_MEMORY * 90 / 100))MiB
fi
if [ ! -z "${SERVER_CPU}" ] && [ "${SERVER_CPU}" != "0" ]; then
    export GOMAXPROCS=$(( (SERVER_CPU + 99) / 100 ))
fi
export GOGC=100

echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# THE FIX: Use eval with exec to ensure the application BECOMES PID 1
# This is the only way to ensure signals (Stop/Restart) work 100% of the time.
eval "exec ${MODIFIED_STARTUP}"

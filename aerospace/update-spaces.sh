#!/bin/bash

# Get the process ID of the Barik app
BAR_PID=$(pgrep -x "Barik")

if [ -z "$BAR_PID" ]; then
    echo "Barik is not running"
    exit 1
fi

# Send a SIGUSR1 signal to the Barik app
kill -SIGUSR1 "$BAR_PID"

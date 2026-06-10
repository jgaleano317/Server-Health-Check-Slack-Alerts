#!/bin/bash
# Monitor disk space and send a warning if it exceeds 80%
THRESHOLD=80
CURRENT_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    echo "CRITICAL: Disk usage is at ${CURRENT_USAGE}%!"
    # Companies routinely pipe this to a Slack webhook curl command here
fi


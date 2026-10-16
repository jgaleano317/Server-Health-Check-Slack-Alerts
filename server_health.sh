#!/bin/bash

set -euo pipefail

# Configuration
DISK_THRESHOLD=80
SLACK_WEBHOOK_URL="${SLACK_WEBHOOK_URL:-}"

# Get the current hostname
HOSTNAME=$(hostname)

# Get root filesystem disk usage
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Checking disk usage on $HOSTNAME..."
echo "Current disk usage: ${DISK_USAGE}%"

# Check whether disk usage exceeds the threshold
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    MESSAGE="⚠️ Disk usage alert on $HOSTNAME: ${DISK_USAGE}% used (threshold: ${DISK_THRESHOLD}%)."

    echo "$MESSAGE"

    # Send Slack alert if a webhook URL is configured
    if [ -n "$SLACK_WEBHOOK_URL" ]; then
        curl -X POST \
            -H "Content-type: application/json" \
            --data "{\"text\":\"$MESSAGE\"}" \
            "$SLACK_WEBHOOK_URL"

        echo "Slack alert sent."
    else
        echo "Slack webhook is not configured. Alert was not sent."
    fi
else
    echo "Disk usage is below the ${DISK_THRESHOLD}% threshold."
fi

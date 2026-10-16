# Linux Server Disk Usage Monitor

A simple Bash script that monitors disk usage on a Linux server and sends a Slack notification when usage reaches a defined threshold.

This project was built as a hands-on Linux/Bash monitoring exercise to practice system monitoring, conditional logic, command-line tools, and alerting through a Slack webhook.

## What It Does

- Checks disk usage on the root filesystem
- Compares usage against a configurable threshold
- Displays the current disk usage in the terminal
- Sends a Slack alert when the threshold is reached
- Keeps the Slack webhook URL outside of the source code

## Technologies

- **Linux**
- **Bash**
- **curl**
- **Slack Incoming Webhooks**
- **df / awk**

## How It Works

The script checks the disk usage of the root filesystem:

```bash
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')
```

The alert threshold can be changed in the script:

```bash
DISK_THRESHOLD=80
```

If disk usage reaches or exceeds the threshold, the script sends a notification to Slack.

Example:

```text
⚠️ Disk usage alert on server01: 85% used (threshold: 80%).
```

## Slack Webhook Setup

The Slack webhook URL should **not** be placed directly in the script or committed to GitHub.

Set it as an environment variable instead:

```bash
export SLACK_WEBHOOK_URL="your-webhook-url"
```

Then run the script:

```bash
./server_health.sh
```

The script will use the environment variable to send alerts to Slack.

> Never commit your actual Slack webhook URL to GitHub. A webhook URL is a secret and should be treated like a credential.

## Usage

Clone the repository:

```bash
git clone https://github.com/jgaleano317/Server-Health-Check-Slack-Alerts.git
cd Server-Health-Check-Slack-Alerts
```

Make the script executable:

```bash
chmod +x server_health.sh
```

Set the Slack webhook:

```bash
export SLACK_WEBHOOK_URL="your-webhook-url"
```

Run the health check:

```bash
./server_health.sh
```

## Example Output

When disk usage is below the threshold:

```text
Checking disk usage on server01...
Current disk usage: 42%
Disk usage is below the 80% threshold.
```

When the threshold is reached:

```text
Checking disk usage on server01...
Current disk usage: 85%
⚠️ Disk usage alert on server01: 85% used (threshold: 80%).
Slack alert sent.
```

## What I Learned

This project helped me practice basic Linux monitoring and Bash automation.

Key areas I practiced include:

- Bash variables and conditional statements
- Linux disk monitoring with `df`
- Processing command output with `awk`
- HTTP requests with `curl`
- Environment variables
- Basic alerting and monitoring concepts
- Keeping secrets out of source code

## Future Improvements

Possible improvements include:

- Monitoring CPU and memory usage
- Adding configurable warning and critical thresholds
- Writing monitoring results to a log file
- Scheduling the script with `cron` or a systemd timer
- Adding additional notification methods
- Returning different exit codes for monitoring integrations

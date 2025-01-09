#!/bin/bash

# Thresholds
CPU_THRESHOLD=50
MEM_THRESHOLD=30
DISK_THRESHOLD=30
EMAIL="prasadsb240801@gmail.com"

# Function to send email alert
send_alert() {
    local subject=$1
    local message=$2
    echo "$message" | mailx -s "$subject" "$EMAIL"
}

# Initialize the alert message
alert_message=""

# Check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage=${cpu_usage%.*}
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    alert_message+="Warning: CPU usage has reached ${cpu_usage}%.\n"
fi

# Check Memory usage
mem_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    alert_message+="Warning: Memory usage has reached ${mem_usage}%.\n"
fi

# Check Disk usage
while IFS= read -r line; do
    mount_point=$(echo "$line" | awk '{print $6}')
    if [[ "$mount_point" =~ ^/(sys|proc|dev|run|tmp) ]]; then
        continue
    fi
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    if [ "$usage" -gt "$DISK_THRESHOLD" ]; then
        alert_message+="Warning: Disk usage on $mount_point has reached ${usage}%.\n"
    fi
done < <(df -h | awk 'NR>1')

# Send the email if there are any alerts
if [ -n "$alert_message" ]; then
    send_alert "Resource Usage Alert" "$alert_message"
else
    echo "$(date): No resource thresholds exceeded." >> /var/log/resource_monitor.log
fi

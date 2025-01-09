# Automated Security and Resource Monitoring System

This project consists of two scripts designed to enhance system security and monitor resource usage. The scripts include:  
1. A Python script for detecting and blocking malicious IPs based on failed login attempts in Nginx logs.  
2. A shell script for monitoring system resources (CPU, memory, and disk) and sending email alerts when thresholds are exceeded.  

Both scripts can be automated using cron jobs for continuous monitoring and response.

---

## Features

### **Python Script: IP Blocking**
- Monitors Nginx access logs in real-time using `tail`.
- Detects repeated failed login attempts based on a specified threshold.
- Blocks malicious IPs dynamically using `iptables`.
- Automatically unblocks IPs after a configurable block duration.
- Maintains a record of blocked IPs in a log file.

### **Shell Script: Resource Monitoring**
- Monitors CPU, memory, and disk usage.
- Sends automated email alerts when usage exceeds predefined thresholds.
- Logs resource usage data for reference.
- Configurable thresholds and email alerts for proactive system management.

---

## Prerequisites

1. **Python Script**:
   - Python 3.x
   - Nginx web server with access to logs (`/var/log/nginx/access.log`).
   - `iptables` installed and configured.
   - Root or sudo privileges for managing `iptables`.

2. **Shell Script**:
   - `mailx` or an equivalent email client configured for sending alerts.
   - Basic utilities: `top`, `free`, `df`.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/automated-monitoring.git
   cd automated-monitoring
   ```

2. Update configurations in the scripts:
   - For the Python script:
     - Set `LOG_FILE` to your Nginx access log file path.
     - Set `BLOCKED_IPS_FILE` to the file path where blocked IPs should be logged.
   - For the shell script:
     - Set `CPU_THRESHOLD`, `MEM_THRESHOLD`, and `DISK_THRESHOLD` to your desired limits.
     - Replace the `EMAIL` variable with your email address.

3. Make the scripts executable:
   ```bash
   chmod +x python_script.py
   chmod +x shell_script.sh
   ```

---

## Usage

### **Run Manually**

- **Python Script**:  
  Run the script to monitor Nginx logs and block IPs in real-time.  
  ```bash
  sudo python3 python_script.py
  ```

- **Shell Script**:  
  Execute the script to check resource usage and send alerts.  
  ```bash
  ./shell_script.sh
  ```

### **Automate with Cron Jobs**

1. Open the cron editor:  
   ```bash
   crontab -e
   ```

2. Add the following entries:
   - Run the Python script every minute:  
     ```bash
     * * * * * /usr/bin/python3 /path/to/python_script.py
     ```
   - Run the shell script every 5 minutes:  
     ```bash
     */5 * * * * /path/to/shell_script.sh
     ```

---

## Logs and Alerts

1. **Blocked IPs**:  
   Blocked IPs are logged in the file specified by `BLOCKED_IPS_FILE`.

2. **Resource Monitoring Logs**:  
   Logs of resource checks are stored in `/var/log/resource_monitor.log`.

3. **Email Alerts**:  
   Email alerts are sent to the address specified in the shell script.

---

## Security Note

- Ensure proper permissions for the scripts to avoid unauthorized modification.  
- Run the scripts as a user with the necessary privileges (`root` or sudo) to manage `iptables` and system resources.

---

## Contributing

Feel free to fork this repository and submit pull requests for improvements or bug fixes.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

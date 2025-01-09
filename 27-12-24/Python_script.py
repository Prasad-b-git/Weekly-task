import subprocess
import time
import re
from datetime import datetime

# Configuration
LOG_FILE = "/var/log/nginx/access.log"
BLOCKED_IPS_FILE = "/etc/nginx/sites-available/blocked_ips.txt"
MAX_FAILED_ATTEMPTS = 5
BLOCK_DURATION = 300  # in seconds
BLOCKED_IPS = set()

def load_blocked_ips():
    """
    Load already blocked IPs from the file to avoid redundant blocking.
    """
    try:
        with open(BLOCKED_IPS_FILE, "r") as file:
            for line in file:
                parts = line.strip().split(" - ")
                if parts:
                    ip = parts[0]
                    BLOCKED_IPS.add(ip)
    except FileNotFoundError:
        open(BLOCKED_IPS_FILE, "w").close()

def block_ip(ip_address):
    """
    Block the given IP using iptables and add it to the blocked IPs file with timestamp.
    """
    if ip_address in BLOCKED_IPS:
        return

    try:
        subprocess.run(["sudo", "iptables", "-A", "INPUT", "-s", ip_address, "-j", "DROP"], check=True)
        BLOCKED_IPS.add(ip_address)
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(BLOCKED_IPS_FILE, "a") as file:
            file.write(f"{ip_address} - Blocked

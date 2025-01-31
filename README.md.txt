# System Monitoring Script

## Overview
This Bash script monitors system resource usage, including disk, CPU, and memory utilization. It logs the data, raises alerts when usage exceeds a specified threshold, and sends an email notification if necessary.

## Features
- Monitors disk usage and alerts if usage exceeds the defined threshold.
- Displays current CPU usage.
- Displays current memory usage, including detailed breakdown.
- Lists top memory-consuming processes.
- Logs all outputs to a specified file.
- Sends an email notification when a threshold is breached.

## Usage
```bash
./monitor.sh [-t threshold] [-f logfile]
```
### Options:
- `-t threshold` : Set the disk usage threshold (default: 80%).
- `-f logfile` : Set the log file name (default: `system_monitor.log`).

### Example:
```bash
./monitor.sh -t 85 -f my_log.log
```
This runs the script with an 85% disk usage threshold and logs to `my_log.log`.

## Requirements
- Linux-based OS
- Bash shell
- `df`, `top`, `free`, `awk`, `sed`, and `ps` commands
- `sendmail` installed and configured for email notifications

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/system-monitor.git
   ```
2. Navigate to the directory:
   ```bash
   cd system-monitor
   ```
3. Make the script executable:
   ```bash
   chmod +x monitor.sh
   ```

## Logging
All outputs are logged in the specified log file. The default log file is `system_monitor.log`.

## Email Alerts
If a threshold is exceeded, an email alert is sent to the configured email address. Ensure that `sendmail` is installed and properly configured.

## License
This project is licensed under the MIT License. Feel free to modify and distribute.

## Author
[Ahmed El-Hadad]


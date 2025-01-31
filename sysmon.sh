#!/bin/bash

# Color definitions
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# Defaults
threshold=80
logfile="system_monitor.log"
email="xviiahmed95@google.com"

# Command-line arguments
while getopts "t:f:" opt; do
  case ${opt} in
    t) threshold=$OPTARG ;;  # Set threshold
    f) logfile=$OPTARG ;;    # Set log file name
    \?) echo "Usage: $0 [-t threshold] [-f logfile]"; exit 1 ;; # Invalid option
  esac
done

# Redirect output to logfile
exec >> $logfile 2>&1

# Alert date
echo "-------------------------------------------------------------------"
date=$(date)
echo -e "${GREEN}System Monitoring Alert - $date${NC}"

alert_raised=false

# Get usage
echo "-------------------------------------------------------------------"
echo -e "\n${GREEN}Partition Use%${NC}\n"

df -h | grep sd | awk '{print $1, $5}' | while read -r line; do
  partition=$(echo $line | awk '{print $1}')
  usage=$(echo $line | awk '{print $2}' | sed 's/%//')
  echo "$line"

  # Check usage threshold
  if [ $usage -gt $threshold ]; then
    echo -e "${RED}WARNING: $partition usage is above $threshold%${NC}"
    alert_raised=true
  fi
done
echo ""

# Print CPU usage
echo "-------------------------------------------------------------------"
echo -e "\n${GREEN}Current CPU Usage%${NC}\n"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1 "%"}'
echo ""

# Print memory usage
echo "-------------------------------------------------------------------"
echo -e "\n${GREEN}Current Memory Usage${NC}\n"
echo "-------------------------------------------------------------------"
# Printing the header
printf "%-12s | %-8s | %-8s | %-8s\n" "Total" "Used" "Free" "Shared"
echo "-------------------------------------------------------------------"

# Printing memory usage
free -h | awk 'NR==2{printf "%-12s | %-8s | %-8s | %-8s\n", $1, $2, $3, $4} NR==3{printf "%-12s | %-8s | %-8s | %-8s\n", $1, $2, $3, $4}'

# Top memory consuming processes
echo "-------------------------------------------------------------------"
echo -e "\n${GREEN}Top Memory Consuming Processes${NC}\n"
ps aux --sort=-%mem | awk 'NR<=6 {print $2, $1, $3, $11}' | column -t
echo ""

# If a threshold was breached, send an email
if [ "$alert_raised" = true ]; then
  echo -e "Subject: System Monitoring Alert\n\nA threshold has been breached. Please check the log file for details." | sendmail $email
fi

echo "///////////////////////////////////////////////////////////////////"
echo "///////////////////////////////////////////////////////////////////"
echo ""
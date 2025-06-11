#!/bin/bash
#
# Disk Monitor Script
#
# This script monitors the disk usage of all mounted filesystems and provides
# a warning if the usage exceeds a specified threshold.
#
# Usage:
#   Run the script directly in a bash shell.
#
# Features:
# - Displays the disk usage of all mounted filesystems.
# - Compares the usage percentage against a predefined threshold.
# - Outputs a warning message if the usage exceeds the threshold.
#
# Variables:
# - THRESHOLD: The percentage of disk usage that triggers a warning. Default is 80%.
#
# Implementation:
# - The `df -h` command is used to retrieve disk usage information in human-readable format.
# - The `awk` command processes the output to extract the usage percentage and filesystem name.
# - A `while` loop iterates through each filesystem, checks the usage, and prints a warning if necessary.
#
# Note:
# - Ensure the script has execute permissions using `chmod +x tabN.sh`.
# - Run the script with appropriate privileges if required to access all filesystems.

THRESHOLD=80

echo "Disk Usage Monitor Script"
echo "--------------------------"

# Check disk usage for each mounted filesystem
df -h | awk 'NR>1 {print $5 " " $1}' | while read output; do
    usage=$(echo $output | awk '{print $1}' | sed 's/%//')
    filesystem=$(echo $output | awk '{print $2}')

    if [ $usage -ge $THRESHOLD ]; then
        echo "Warning: $filesystem is at ${usage}% usage!"
    fi
done
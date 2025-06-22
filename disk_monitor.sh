#!/bin/bash


# 🎯 Task Description:
# Write a Bash script that:
# Checks the disk usage of the / (root) partition.
# If usage is ≥ 80%, it prints a warning message.
# If usage is < 80%, it prints that the usage is normal.


# 1. INPUT: Get disk usage for /
# 2. PROCESS: Extract the usage percentage
# 3. CONDITION: Check if usage >= 80
# 4. OUTPUT: Print warning or normal message


USAGE=$(df -h / | tail -n 1 | awk '{print($5)}'| tr -d "%")

if [ "$USAGE" -ge 80 ]; then
    echo " [ WARNING ]: Your Usage is HIGH just above 80%"
else 
    echo " Your usage is normal"
fi
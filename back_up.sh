#!/bin/bash

#  Day 5: Backup Old Logs
# 🎯 Task Description:
# Write a Bash script that:
# Finds all .log files inside /var/log that are older than 7 days.
# Archives them into a single file named:
# old_logs.tar.gz
# (stored in the current directory or a defined backup folder).


# PLAN:
# INPUT: find all .log files inside /var/log 
# CONDITION: that are older than 7 days
# PROCESS: Not required 
# OUTPUT: Archive them into a single file name: old_logs_.tar.gz

SOURCE_PATH="/var/log"
DATE=$(date +%F)
ARCHIVE_NAME="old_logs_$DATE.tar.gz"
temp_log_list=$(mktemp)

if [ -d "$SOURCE_PATH" ]; then
    
    find "$SOURCE_PATH" -name '*.log' -mtime +6 2>/dev/null > "$temp_log_list "
    
    if [ -n "$temp_log_list " ]; then
        tar -czf "$ARCHIVE_NAME" -T "$temp_log_list" 2>/dev/null;
        echo "Successfully Archived Logs";
        rm -f "$temp_log_list";

    else
        echo "No old .log files found."
    fi  

else
    echo "File path not found";
    exit 1
fi
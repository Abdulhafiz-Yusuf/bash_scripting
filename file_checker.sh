#!/bin/bash


#1. INPUT
# Accepts a filename as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>";
    exit  1
fi
#2. CONDITION & REPORT
# Checks if it exists
# If it exists, prints “File exists”
# Else, prints “File not found”
if [ -e "$1" ]; then
    echo "File '$1' exist"
else
    echo "File '$1' not found"
fi

#3. PROCESSING: Not required


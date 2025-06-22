#!/bin/bash

# This script Extract and analyze important events from logs
# Features:
#   1. Accept a log file path as an argument.
# 	2. Check if file exists and is readable.
# 	6. Optional: Group errors by date (assumes logs include a timestamp).
# 	7. Print a summary at the end.

# Solution:
#   1. Accespt a log file path as an argument.
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi
# 	2. Check if file exists and is readable.
if [ ! -r $1 ]; then
    echo "File $1 provided not readable or exist"
    exit1
fi

# 	3. Search for keywords: ERROR, CRITICAL, FAILED.
# 	4. Save matching lines to error_report.txt.
# 	5. Count how many times each keyword appears.
errorReportFile="./errorReport.txt"
echo -e "\n\nSUMMARY OF ERROR REPORT\n\nError count group by keyword" > $errorReportFile
for keyword in ERROR FAILED CRITICAL; do
error_count=$(grep -iEc $keyword $1)
echo "$keyword: $error_count" >> $errorReportFile
done

# 	6. Optional: Group errors by date (assumes logs include a timestamp).
echo -e "\n\nError count group by date" >> $errorReportFile
grep -iE "ERROR|FAILED|CRITICAL" $1| awk -F "-" '{print $1,$2,substr($3,1,2)}' | sort | uniq -c | while read count date; do
echo "$date: $count" >> $errorReportFile
done 

# 	7. Print a summary at the end.
cat $errorReportFile
echo -e "Error report saved to $errorReportFile\n"
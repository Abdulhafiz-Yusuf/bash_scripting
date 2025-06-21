#!/bin/bash

# User Account Audit Script
# 🎯 Goal: Review user accounts for access and activity.
# Step-by-step Features:
# 	1. Filter users with /bin/bash as their shell from /etc/passwd
# 	2. Print a clean table of "username | shell | sudo (yes/no) | active status
# 	4. Use lastlog to find inactive users (>30 days).
# 	5. Save results to user_audit_report.txt.


# Step-by-step Features:

# 	1. Filter users with /bin/bash as their shell from /etc/passwd
REPORT_FILE="./userAuditReport.txt"

if [ ! -e "$REPORT_FILE" ]; then
    touch $REPORT_FILE
fi
echo -e "Username\t|\tShell\t|\tSudo_status\t|\tActive_status" > $REPORT_FILE
#username:password:UID:GID:GECOS:home_directory:shell
while IFS=: read -r username _ uid gid _ _ shell; do
    if [ $uid -ge 1000 ] && [ $shell = "/bin/bash" ]; then
       
        # Check if user is in sudo group using groups
        if id -nG "$username" | grep -qw "sudo"; then
            sudo_status="Yes"
         else 
            sudo_status="No"

        fi
        # output of a lastlog command:
        #bandit0@bandit:~$ lastlog 
        # Username Port     From                        Latest
        # root     pts/248  2.249.152.88                Mon Jun 16 12:21:32 +0000 2025
        # daemon                                        **Never logged in**
        
        last_login=$(lastlog -u "$username" | tail -n 1)
        echo $last_login

        if echo "$last_login" | grep -iq "never"; then
            active_status="Inactive"    
        else
            last_login=$(lastlog -u "$username" | awk 'NR==2 {print $4, $5, $6}')
            last_login_timestamp=$(date -d "$last_login" +%s)
            current_date_timestamp=$(date +%s)
            diff_timestamp_in_seconds=$(( current_date_timestamp - last_login_timestamp ))
            diff_days=$(( diff_timestamp_in_seconds / 86400 ))           
           
            if [ $diff_days -ge 30 ]; then
                active_status="Inactive"
            else
                active_status="Active"
            fi
        
            # 	2. Print a clean table of "username|shell|sudo(yes/no)|active status (>30 days)
            echo -e "$username\t|\t$shell\t|\t$sudo_status\t|\t$active_status" >> $REPORT_FILE
        fi
    fi
done < "/etc/passwd"


# 	5. Save results to user_audit_report.txt.

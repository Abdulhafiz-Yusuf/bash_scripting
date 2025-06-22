#!/bin/bash

# PROBLEM
# Write a Bash script that:
# Lists all users whose default shell is /bin/bash (i.e., real login users).
# For each user, check if they are currently logged in or not.
# Print a report like:


#Solution:
#1. INPUT: /etc/passwd
#2. CONDITION/LOOP: list users if shell is /bin/bash and id >= 1000
#1. PROCESSING: 
#1. OUTPUT: Print user 

#1. INPUT/SETUP, LOOP/CONDITION AND OUPUT
REPORT_FILE="./logged_in_user.txt"
echo "Login User Report $(date)" > "$REPORT_FILE"

#username:password:UID:GID:GECOS:home_directory:shell
while IFS=: read -r username _ uid gid _ home shell; do
    if [ "$uid" -ge 1000 ] && [ "$shell" = "/bin/bash" ]; then
      
        if pgrep -u "$username" >/dev/null 2>/dev/null ; then
            echo "User: "$username"  --> Logged In " >> $REPORT_FILE
        else
            echo "User: "$username"  --> Not Logged In" >> $REPORT_FILE
        
        fi 
    fi
done < "/etc/passwd"
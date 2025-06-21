#!/bin/bash

#1. Check if user provided at least one service name
#2. Loop through each service passed as argument: For each get the service status using systemctl"
#3. Print status: Create a function to print in this format: 
    # 2025-06-21 16:45:10 - nginx: active
    # 2025-06-21 16:45:10 - sshd: active
    # 2025-06-21 16:45:10 - mysql: failed
#4. Colour the output: Green for active, red for faile and inactive and yellow for unknown.

#Solution:

LOG_FILE="./service_status.log"


print_status () {
        local service=$1
        local status=$2
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        #4. Colour the output: Green for active, red for faile and inactive and yellow for unknown.
        case status in
        active) echo -e "\e[32m$service: $status\e[0m"
        ;;
        failed|inactive) echo -e "\e[33m$service: $status\e[0m"
        ;;
       *) echo -e "\e[33m$service: $status\e[0m"
        esac

        echo "$timestamp - $service : $status" >> $LOG_FILE
    }


#1. Check if user provided at least one service name
if [ $# -eq 0 ]; then
    echo "[ ERROR ] Usage: $0 <service1> <service2> .."
fi

#2. Loop through each service passed as argument: For each get the service status using systemctl"
for service in $@; do
    echo "\$#: $#"
    status=$(systemctl is-active "$service" 2>/dev/null)
    echo $status

    if [ $? -ne 0 ]; then
        status="Unknown"
    fi

    #3. Print status: Create a function to print in this format: 
    # 2025-06-21 16:45:10 - nginx: active
    # 2025-06-21 16:45:10 - sshd: active
    # 2025-06-21 16:45:10 - mysql: failed
    print_status $service $status    

done


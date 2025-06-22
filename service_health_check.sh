#!/bin/bash


# INPUT: Service as argument from command line
# CONDITION: systemcl is-active
# PROCESSING: Not required
# OUTPUT: E.G Service 'nginx' is active.

SERVICE_LOG_FILE="./service_status.log"
#header for SERVICE_LOG_FILE
 echo "----------------------------------------" >> "$SERVICE_LOG_FILE"
 echo "Services Active Status Report $(date)"  >> $SERVICE_LOG_FILE
 echo "----------------------------------------" >> "$SERVICE_LOG_FILE"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <service>";
    exit 1
fi

for service in $@; do
    ACTIVE_STATUS=$(systemctl is-active "$service")
    echo "$(date) '$service': $ACTIVE_STATUS" >> "$SERVICE_LOG_FILE"
done


# OUTPUT I GOT IN $SERVICE_LOG_FILE:

# Service Active Status Report
# Sun Jun 22 10:35:21 WAT 2025 kibana: failed
# Sun Jun 22 10:35:21 WAT 2025 docker: active
# Sun Jun 22 10:35:21 WAT 2025 airflow: inactive
# Sun Jun 22 10:35:21 WAT 2025 nginx: inactive
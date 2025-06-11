#!/bin/bash -x
#OBJECTIVE: I want to create a Disk Monitor that will check if disk usage is within threshold of 70%

###### STEPS ########
#
#1. Define threshold
#2. Determine current usage status
#3. Check if usage is within threshold.
#4. Send mail to admin if usage is above threshold of 70%
#
#



# step 1
#
BOT_TOKEN="7550863964:AAFbdpfC6drGwlTd3znhd3c1HQBoo1aLz9w"
CHAT_ID="5014233490"
THRESHOLD=90
#7550863964:AAFbdpfC6drGwlTd3znhd3c1HQBoo1aLz9w
#
THRESHOLD=70
# step 2
USAGE=$(df / | awk 'NR >1 {print $5}'| tr -d '%' )
# step 3 and 4
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d "chat_id=${CHAT_ID}" \
    -d "text=🚨 Disk usage is over ${THRESHOLD}%!"
else echo "You are very much okay"
fi


# create a clean

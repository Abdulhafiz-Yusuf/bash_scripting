#!/bin/bash
#
#--------------------------------------------
#     ADD USER AND SET BASH AS USER SHELL
#--------------------------------------------
#
#STEPS
# 1. Collect user from option
# 2. use while loop and ":u:s" option
# 3. set u and s option for user and shell respective
# 4. print out user and shell
#
# Solution

while getopt ":u:s" opt; do
    case $opt in 
        u) user=$OPTARG;;
        s) shell=$OPTARG;;
        *) exit 1 ;;
    esac
done

echo "user: $user"
echo "shell: $shell"

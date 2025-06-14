#!/bin/bash

# This script adds a new user to the system with a specified username and password.
# Note: This script requires sudo privileges to execute successfully.
# The -h option displays the usage information for the script.



while getopts ":u:s:h" option; do
   case $option in 
       u) user=$OPTARG;;
       s) shell=$OPTARG;;
       h) echo "Usage: $0 -u USERNAME -s SHELL [-h]"; exit 0;;
       *) echo "Usage: $0 -u USERNAME -s SHELL [-h]"; exit 1;;
    esac
done

if [[ -z "$user" || -z "$shell" ]]; then 
    echo "Error: user and shell are required!"
    echo "Usage: $0 -u USERNAME -s SHELL [-h]"
fi


if id -u "$user" >/dev/null 2>&1; then
    echo "Error: User '$user' already exists!"
    exit 1
fi

if ! grep -Fxq "$shell" /etc/shells; then
    echo "Error: Invalid shell specified!"
    exit 1
fi

if ! sudo -v >/dev/null 2>&1; then
    echo "Error: Insufficient privileges. Please run the script with sudo."
    exit 1
fi

if ! sudo useradd -m -s "$shell" "$user"; then
    echo "Error: Failed to add user"
    exit 1
fi


if [[ $? -ne 0 ]]; then
    echo "Error: Failed to add user"
    exit 1
echo "Assigned shell: $shell"
fi

echo "User: $user"
echo "Shell: $shell"

#!/bin/bash


# SCRIPT TO ADD USER TO SYSTEM USING OPTION -u (username) -s (shell) AND -h (help or usage info) 
#
# With the following features:
# 1. collect options from cli and set $user=-u_arg and $shell=-s_arg
# 2. check if option is not empty and user does exist already 
# 3. check if shell is a valid shell before adding to system user.
# 4. check if script with enough privilege (sudo) or not
# NB: ONLY ADD USER IF $user DOES NOT ALREADY EXIST, SHELL IS A VALID SHELL AND SCRIPT IS RUN USING SUDO.

# With the following features:
# 1. collect options from cli and set $user=-u_arg and $shell=-s_arg
while getopts ":u:s:h" opt; do
    case $opt in
        u) user=$OPTARG;;
        s) shell=$OPTARG;;
        h) echo "Usage: $0 -u username -s shell [-h]"; exit 0;;
        *) echo "Usage: $0 -u username -s shell [-h]"; exit 1;;
    esac
done
# Testing
#echo "user to be added: " $user
#echo "user shell: " $shell

# 2. check if option is not empty, user does exist already and shell provided is valid shell
if [[ -n "$user" && -n "$shell" ]]; then

    # checking if user already exist
    if id -u "$user" > /dev/null 2>&1; then
        echo "Error: User '$user' already exists!" >&2
        exit 1
    fi

    # checking if shell is valid
    if ! grep -Fqx "$shell" /etc/shells > /dev/null 2>&1; then
        echo "Error: Invalid shell specified" >&2
        exit 1
    fi

    # check if script has sudo privileges
    if ! sudo -v >/dev/null 2>&1; then
        echo "Error: Insufficient privileges. Please run with sudo." >&2 
        exit 1
    fi
    # adding user with specified shell 
    # using -m to create home directory and -s to specify shell
    # using sudo to ensure the command runs with elevated privileges
   if sudo useradd -m -s "${shell}" "${user}"; then
        echo "User ${user} added successfully"
    else
        echo "Error: Failed to add user" >&2
        exit 1
    fi

else 
    echo "Error: Both username (-u) and shell (-s) options are required!";
    echo "Usage: '$0' -u USERNAME -s SHELL [-h]"
fi

# NB: ONLY ADD USER IF $user DOES NOT ALREADY EXIST, SHELL IS A VALID SHELL AND SCRIPT IS RUN USING SUDO.

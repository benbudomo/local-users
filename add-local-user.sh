#!/bin/bash
# This script creates new user accounts

# Enforces root privileges
if [[ "${UID}" -ne 0 ]]
then
    echo 'Please execute script with root privileges.'
    exit 1
fi
# Prompts for username
read -p 'Enter username: ' USER_NAME

# Prompts for name of user
read -p 'Enter name of user: ' REAL_NAME

# Prompts for initial password 
read -p 'Enter intial password: ' PASSWORD

# Creates the user account
useradd -c "${REAL_NAME}" -m ${USER_NAME}
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login
passwd -e ${USER_NAME}

# Informs if account was not created
if [[ "${?}" -ne 0 ]] 
then
    echo 'Mission Failed.'
    exit 1
fi

# Displays username, password, and host
HOST_NAME=$(hostname)
echo "USERNAME: ${USER_NAME}"
echo "REAL NAME: ${REAL_NAME}"
echo "HOST NAME: ${HOST_NAME}"

exit 0
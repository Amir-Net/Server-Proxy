#!/bin/bash
# -----------------------------------------------------------------------------
# Description: This script automates the setup and configuration of various
#              utilities and services on a Linux server for a secure and
#              optimized environment.
#
# Author: BabyBoss
# GitHub: https://github.com/Amir-Net/
#
# Disclaimer: This script is provided for educational and informational
#             purposes only. Use it responsibly and in compliance with all
#             applicable laws and regulations.
#
# Note: Make sure to review and understand each section of the script before
#       running it on your system. Some configurations may require manual
#       adjustments based on your specific needs and server setup.
# -----------------------------------------------------------------------------
# Check for sudo privileges
if [[ $EUID -ne 0 ]]; then
  if [[ $(sudo -n true 2>/dev/null) ]]; then
    echo "This script will be run with sudo privileges."
  else
    echo "This script must be run with sudo privileges."
    exit 1
  fi
fi
clear

# Function to print characters with delay
print_with_delay() {
    text="$1"
    delay="$2"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo
}

# Introduction animation
echo ""
echo ""
print_with_delay "SSH-installer by Amir | @BabyBoss" 0.1
echo ""
echo ""

 # Prompt the user for the new SSH port
  read -p "Enter New SSH Port:" ssh_port

  # Verify that a valid port number is provided
  if [[ $ssh_port =~ ^[0-9]+$ ]]; then
    # Remove the '#' comment from the 'Port' line in sshd_config (if present)
    sudo sed -i "/^#*Port/s/^#*Port/Port/" /etc/ssh/sshd_config

    # Update SSH port in sshd_config
    sudo sed -i "s/^Port .*/Port $ssh_port/" /etc/ssh/sshd_config

    # Reload SSH service to apply changes
    sudo systemctl reload sshd
    echo "SSH port changed to $ssh_port."
    unset ssh_port
    read -p "Press enter key to continue"
    else
    echo "Invalid port number. Please provide a valid port."
  fi

  # read on-login users
  read -p  "Enter your usernames (comma-separated, e.g. A,B):" user_names
  
  # Add names to the user
    if [ -n "$user_names" ]; then
    IFS=',' read -ra names_array <<< "$user_names"
    for port in "${names_array[@]}"; do
      sudo adduser "$port" --shell /usr/sbin/nologin
    done
  fi
  unset user_names
  read -n 1 -s -r -p "Press any key to continue"
  
 # install UDP Getway
  bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/udpgw.sh)"
  read -n 1 -s -r -p "Press any key to continue"

  # install TCP Tweaker
  bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/tweaker.sh)"

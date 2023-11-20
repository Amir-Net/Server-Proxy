# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  if [[ $(sudo -n true 2>/dev/null) ]]; then
    echo "This script must be run with root access."
  else
    echo "This script must be run with root access."
    exit 1
  fi
  echo "Please enter root password and run script again."
  su root
fi
clear

 #....

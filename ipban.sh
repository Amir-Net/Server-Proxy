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

# Block iran ip
sudo apt-get update -y
sudo apt-get -y upgrade
sudo apt-get install curl unzip perl xtables-addons-common libtext-csv-xs-perl libmoosex-types-netaddr-ip-perl iptables-persistent -y 
sudo mkdir /usr/share/xt_geoip

sudo wget -4 -O /usr/local/bin/geo-update.sh https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipgeo.sh

chmod 755 /usr/lib/xtables-addons/xt_geoip_build
bash /usr/local/bin/geo-update.sh

sudo iptables -A OUTPUT -m geoip -p tcp --destination-port 80 --dst-cc IR -j DROP
sudo iptables -A OUTPUT -m geoip -p tcp --destination-port 443 --dst-cc IR -j DROP
iptables-save
clear
echo -e "Blocked Port 80 and 443 IRAN \n"

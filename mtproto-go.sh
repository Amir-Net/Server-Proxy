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

 # MTG mtproto installer
  wget https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg-2.1.7-linux-amd64.tar.gz
  tar -xzf mtg-2.1.7-linux-amd64.tar.gz
  cp mtg-2.1.7-linux-amd64/mtg /usr/local/bin
  cp mtg-2.1.7-linux-amd64/mtg /bin
  chmod +x /usr/local/bin/mtg
  chmod +x /bin/mtg
  rm mtg-2.1.7-linux-amd64.tar.gz
  rm -r mtg-2.1.7-linux-amd64

  # MTG mtproto config
  wget -P /etc https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.toml
  wget -P /etc/systemd/system https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.service

  # MTG mtproto runing
  systemctl daemon-reload
  systemctl enable mtg
  systemctl start mtg
  mtg access /etc/mtg.toml

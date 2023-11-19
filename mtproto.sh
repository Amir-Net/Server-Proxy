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

# Old Golang uninstall
sudo apt-get -y remove golang
sudo apt-get -y remove golang-go
sudo rm -rvf /usr/local/go/
sudo rm -rvf /etc/paths.d/go
  
 # Golang install
  cd ~
  wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
  sed -i -e '$aexport PATH=$PATH:/usr/local/go/bin' ~/.profile
  source ~/.profile
  go version
  rm go1.21.4.linux-amd64.tar.gz

 # MTG mtproto installer
  wget https://github.com/9seconds/mtg/releases/download/v2.1.7/mtg-2.1.7-linux-amd64.tar.gz
  tar -xzf mtg-2.1.7-linux-amd64.tar.gz
  cp mtg-2.1.7-linux-amd64/mtg /usr/local/bin
  cp mtg-2.1.7-linux-amd64/mtg /bin
  chmod +x /usr/local/bin/mtg
  chmod +x /bin/mtg
  rm mtg-2.1.7-linux-amd64.tar.gz
  go install github.com/9seconds/mtg/v2@latest

  # MTG mtproto config
  wget -p /etc https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.toml
  wget -p /etc/systemd/system https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.service

  # MTG mtproto runing
  systemctl daemon-reload
  systemctl enable mtg
  systemctl start mtg
  mtg access /etc/mtg.toml

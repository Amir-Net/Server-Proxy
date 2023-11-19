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

# Old Golang uninstall
sudo apt-get -y remove golang
sudo apt-get -y remove golang-go
sudo rm -rvf /usr/local/go/
sudo rm -rvf /etc/paths.d/go
  
 # Golang install
  cd ~
  sudo wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
  sed -i -e '$aexport PATH=$PATH:/usr/local/go/bin' ~/.profile
  source ~/.profile
  go version
  sudo rm go1.21.4.linux-amd64.tar.gz

 # MTG mtproto installer
  sudo wget https://github.com/9seconds/mtg/releases/download/v2.1.7/mtg-2.1.7-linux-amd64.tar.gz
  sudo tar -xzf mtg-2.1.7-linux-amd64.tar.gz
  sudo cp mtg /usr/local/bin
  sudo cp mtg /bin
  chmod +x /usr/local/bin/mtg
  chmod +x /bin/mtg
  sudo rm mtg-2.1.7-linux-amd64.tar.gz
  
  git clone https://github.com/9seconds/mtg.git
  cd mtg
  make static

  # MTG mtproto config
  sudo wget -p /etc https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.toml
  sudo wget -p /etc/systemd/system https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtg.service
  sudo systemctl daemon-reload
  sudo systemctl enable mtg
  sudo systemctl start mtg
  sudo systemctl status mtg

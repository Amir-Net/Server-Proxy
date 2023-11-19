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
 apt-get -y remove golang
 apt-get -y remove golang-go
 rm -rvf /usr/local/go/
 rm -rvf /etc/paths.d/go
  
 # Golang install
  cd ~
  wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
  sed -i -e '$aexport PATH=$PATH:/usr/local/go/bin' ~/.profile
  source ~/.profile
  go version
  rm go1.21.4.linux-amd64.tar.gz
  apt install -y golang-go

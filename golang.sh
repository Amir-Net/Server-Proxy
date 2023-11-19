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

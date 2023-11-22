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

      # C mtproto installer
      apt install git curl build-essential libssl-dev zlib1g-dev
      git clone https://github.com/TelegramMessenger/MTProxy
      cd MTProxy
      make && cd objs/bin
      curl -s https://core.telegram.org/getProxySecret -o proxy-secret
      curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf
      head -c 16 /dev/urandom | xxd -ps
      ./mtproto-proxy -u nobody -p 8888 -H 443 -S <secret> --aes-pwd proxy-secret proxy-multi.conf -M 1
      wget -P /etc/systemd/system https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/MTProxy.service
      systemctl daemon-reload
      systemctl enable MTProxy.service
      systemctl start MTProxy.service
      systemctl status MTProxy.service

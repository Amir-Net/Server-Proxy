# Server-Proxy
Multi Proxy Server Script Installer
1-MTPROTP Script Installation steps on Ubuntu Connect to your server through ssh and copy and run the following command in the terminal
```
bash -c "$(curl -Lfo- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/mtproto.sh)"
```
2- IP Ban Script Installation steps on Ubuntu Connect to your server through ssh and copy and run the following command in the terminal
```
bash <(wget -qO- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipban.sh) -install yes -io OUTPUT -geoip CN,IR -limit DROP
bash <(wget -qO- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipban.sh) -add yes -io INPUT -geoip CN,IR -limit DROP
bash <(wget -qO- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipban.sh) -reset yes
bash <(wget -qO- https://raw.githubusercontent.com/Amir-Net/Server-Proxy/main/ipban.sh) -remove yes
```

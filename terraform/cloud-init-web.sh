#!/bin/sh

# flush iptables rules before enabling UFW
sudo iptables -F

# configure uncomplicated firewall
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow http
sudo ufw reload

# install NGINX
sudo apt update
sudo apt install nginx -y

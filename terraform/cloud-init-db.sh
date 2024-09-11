#!/bin/sh

# flush iptables rules before enabling UFW
sudo iptables -F

# configure uncomplicated firewall
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 27017/tcp
sudo ufw reload

# mongo: Import the Public Key
sudo apt-get install gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

# mongo: Create the List File
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# mongo: Reload the Package Database
sudo apt-get update

# mongo: Install MongoDB Community Server
sudo apt-get install -y mongodb-org

# mongo: enable and start the service
sudo systemctl enable mongod
sudo systemctl start mongod

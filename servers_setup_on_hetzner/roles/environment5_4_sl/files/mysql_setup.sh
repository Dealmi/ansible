#!/bin/bash

#Registering the right pubkey
PUBKEY=$(sudo apt-get update | grep NO_PUBKEY | awk '{print $NF}') 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "$PUBKEY"

sudo apt update
sudo apt-cache policy mysql-server

# Pre-seed the answer 
echo "mysql-community-server  mysql-community-server/root-pass password" | sudo debconf-set-selections
echo "mysql-community-server  mysql-community-server/re-root-pass password" | sudo debconf-set-selections

# Install the package non-interactively
sudo DEBIAN_FRONTEND=noninteractive apt-get install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7* -y
sudo mysql_secure_installation -pIamroot! -D


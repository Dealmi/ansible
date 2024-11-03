#!/bin/bash

# Pre-seed the answer (Replace "ubuntu bionic" with the version you select)
echo "mysql-apt-config mysql-apt-config/repo-distro select ubuntu" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-tools select Enabled" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-preview select Disabled" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-product select Ok" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/unsupported-platform select ubuntu bionic" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/repo-codename select bionic" | sudo debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | sudo debconf-set-selections


# Install the package non-interactively
sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.12-1_all.deb

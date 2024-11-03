#!/bin/bash

./aws_secrets.sh -s prod/ansiblesecrets -f out.env -e
source out.env
rm -f out.env
wget  https://artifacts.mediastream.ag/repository/deb-ansible/pool/m/mysql-apt-config/mysql-apt-config_0.8.12-1_all.deb --user=ansible --password="$artifacts_password" -P roles/environment5_4_sl/files/

ansible-playbook --private-key=~/.ssh/id_rsa_ansible --become-method=sudo server-5.4-slave.yml -v

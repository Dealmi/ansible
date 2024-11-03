#!/bin/bash
./aws_secrets.sh -s prod/ansiblesecrets -f out.env -e
source out.env
rm -f out.env
wget https://artifacts.mediastream.ag/repository/deb-ansible/pool/l/libtomcat8-java/libtomcat8-java_8.5.30-1ubuntu1_all.deb --user=ansible --password="$artifacts_password" -P roles/environment5_4_app/files/
wget https://artifacts.mediastream.ag/repository/deb-ansible/pool/t/tomcat8-common/tomcat8-common_8.5.30-1ubuntu1_all.deb --user=ansible --password="$artifacts_password" -P roles/environment5_4_app/files/
wget https://artifacts.mediastream.ag/repository/deb-ansible/pool/t/tomcat8/tomcat8_8.5.30-1ubuntu1_all.deb --user=ansible --password="$artifacts_password" -P roles/environment5_4_app/files/

echo "Writing redis config..."
cat > roles/environment5_4_app/files/redis.service <<EOF
[Unit]
Description=redis container
After=docker.service
Requires=docker.service

[Service]
User=root
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker stop redis
ExecStartPre=-/usr/bin/docker rm redis
ExecStartPre=/usr/bin/docker pull redis:6.0.4-alpine
ExecStart=/usr/bin/docker run -p 127.0.0.1:6379:6379 -d -i -t --name=redis redis:6.0.4-alpine --requirepass $redispass

[Install]
WantedBy=multi-user.target
EOF

ansible-playbook --private-key=~/.ssh/id_rsa_ansible --become-method=sudo server-5.4-app.yml -vvv

#!/bin/bash
 
echo "Installing nginx maintenance config"
ln -sf /etc/nginx/sites-available/default.maintenance /etc/nginx/sites-enabled/default
 
systemctl reload nginx
 
echo "Stopping engine"
systemctl stop engine
 
echo "Waiting 5 secs"
sleep 5
 
echo "Starting engine"
systemctl start engine
 
echo "Waiting 5 secs"
sleep 5
 
echo "Waiting for server startup..."
while : ; do
  if wget localhost:9000/engine/time --timeout=60 --tries=0 -q --spider; then
    break;
  else
    sleep 3
  fi
done
 
echo "Installing nginx work config"
ln -sf /etc/nginx/sites-available/default.work /etc/nginx/sites-enabled/default
 
systemctl reload nginx

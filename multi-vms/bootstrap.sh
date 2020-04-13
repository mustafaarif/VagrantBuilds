#!/usr/bin/env bash

sudo dhclient enp0s8 -v
PASS=`< /dev/urandom tr -dc _A-Za-z0-9 | head -c${1:-6}`
sudo useradd -m -s /bin/bash student
sudo echo "student:$PASS" | chpasswd
sudo adduser student sudo
echo 'student ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
IPADDR=`ip route get 8.8.8.8 | awk '{print $7; exit}'`
echo "ssh student@$IPADDR Password: $PASS Hostname: $HOSTNAME" >> /etc/host.info
sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
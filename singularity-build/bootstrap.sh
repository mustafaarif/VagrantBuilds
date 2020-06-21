#!/usr/bin/env bash

# Setup network and user authentication
sudo dhclient enp0s8 -v
PASS=`< /dev/urandom tr -dc _A-Za-z0-9 | head -c${1:-6}`
sudo useradd -m -s /bin/bash marif
sudo echo "marif:$PASS" | chpasswd
sudo adduser marif sudo
echo 'marif ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
IPADDR=`ip route get 8.8.8.8 | awk '{print $7; exit}'`
echo "ssh marif@$IPADDR Password: $PASS Hostname: $HOSTNAME" >> /etc/host.info
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Build Singularity
GO_VER=1.13
SING_VER=3.5.3
# Install pre-reqs for Singularity
sudo apt-get update && sudo apt-get -y install build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev wget pkg-config git cryptsetup
# Install Go
export OS=linux ARCH=amd64
wget https://dl.google.com/go/go$GO_VER.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzvf go$GO_VER.$OS-$ARCH.tar.gz
sudo ln -fs /usr/local/go/bin/go /usr/local/bin/go
sudo ln -fs /usr/local/go/bin/gofmt /usr/local/bin/gofmt
# Install Singularity
wget https://github.com/sylabs/singularity/releases/download/v${SING_VER}/singularity-${SING_VER}.tar.gz
tar -xzf singularity-$SING_VER.tar.gz && cd singularity
sudo ./mconfig && make -C builddir && sudo make -C builddir install

# Cleanup
sudo userdel -r ubuntu
cd ..
rm -f go$GO_VER.$OS-$ARCH.tar.gz
rm -rf singularity
rm -f singularity-$SING_VER.tar.gz
#!/usr/bin/env bash

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

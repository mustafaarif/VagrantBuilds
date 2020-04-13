# VagrantLauncher

Vagrant Launcher facilitates launching multiple VMs for Singularity Training.
Creates student account in the VM and generates a random password.
IP addr of VM hosts and login information is written in /etc/hosts.info on each VM.

## Launch VM's
```sh
git clone https://github.com/mustafaarif/VagrantLauncher.git
cd VagrantLauncher
vagrant up
```

## Fetch information on host/password/IP
```sh
vagrant ssh ws01 -c cat /etc/hosts.info
```
## Destroy VM's
To destroy VM's, issue below in same directory
```sh
vagrant destroy
```

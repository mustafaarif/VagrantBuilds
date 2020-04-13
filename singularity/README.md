# Vagrant build file for Singularity Linux Containers

## Launch the build

```sh
git clone ...
```

## Login to the VM
```sh
vagrant ssh
```

## (Optional) 

If you have made any changes in the VM and want to export the box,

```sh
VBoxManage list vms
vagrant package --base 7fe6c8fb-38c5-4de0-bb63-c1e603b6c8a3 --output singularity-ubuntu-bionic64.box
md5 singularity-ubuntu-bionic64.box
```
Upload the .box file to Vagrant Cloud.

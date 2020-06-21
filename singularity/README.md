# Vagrant build file for Singularity Linux Containers

This build file installs singularity on Ubuntu VM.

## Launch the build

```sh
git clone ...
vagrant up
```

## Login to the VM
```sh
vagrant ssh
```

## (Optional) 

If you have made any changes in the VM and want to export the box,

```sh
vagrant package --output singularity-ubuntu-bionic64.box
md5 singularity-ubuntu-bionic64.box
```
Upload the .box file to Vagrant Cloud.

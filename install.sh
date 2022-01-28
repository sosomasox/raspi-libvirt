#!/bin/bash -x

sudo apt update
sudo apt install -y cpu-checker

eval kvm-ok

if [ $? -ne 0 ]; then
    echo KVM acceleration cannot be used
    exit 1
fi

sudo apt install -y \
    qemu-kvm \
    qemu-utils \
    ipxe-qemu \
    libvirt-daemon-system \
    virtinst \
    virt-top \
    bridge-utils \
    libguestfs-tools

sudo usermod -aG kvm          ubuntu
sudo usermod -aG libvirt      ubuntu
sudo usermod -aG libvirt-qemu ubuntu

sudo systemctl is-active libvirtd
sudo virt-host-validate
sudo virsh nodeinfo

exit 0

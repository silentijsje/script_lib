#!/bin/bash

# Prompt the user for the download URL and VM ID
read -p "Enter the Ubuntu cloud image download URL: " IMG_URL
read -p "Enter the VM ID: " VM_ID
read -p "Enter the ubuntu version: " UBUNTU_VERSION
read -sp "Enter the password for the VM user: " PASSWORD
echo

# Extract the image name from the URL
IMG_NAME=$(basename $IMG_URL)

# Download the Ubuntu cloud image
curl -O $IMG_URL

# Install libguestfs-tools if not already installed
apt update
apt install libguestfs-tools -y

# Customize the image to install qemu-guest-agent
virt-customize -a $IMG_NAME --install qemu-guest-agent

# Create a new VM with the specified parameters
VM_NAME="ubuntu-"$UBUNTU_VERSION"-cloud-init"
MEMORY=2048
CORES=2
SOCKETS=1
DISK_PATH="local-lvm"
NET_BRIDGE="vmbr0"

qm create $VM_ID \
  --name $VM_NAME --numa 0 --ostype l26 \
  --cpu cputype=host --cores $CORES --sockets $SOCKETS \
  --memory $MEMORY \
  --net0 virtio,bridge=$NET_BRIDGE

# Import the downloaded disk image to the VM
qm importdisk $VM_ID $IMG_NAME $DISK_PATH

# Configure the VM's storage and boot settings
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $DISK_PATH:vm-${VM_ID}-disk-0
qm set $VM_ID --ide2 $DISK_PATH:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0

# Set serial and VGA configurations
qm set $VM_ID --serial0 socket --vga serial0

# Enable the QEMU guest agent
qm set $VM_ID --agent enabled=1

#Enable dhcp on the template
qm set $VM_ID --ipconfig0 ip=dhcp

#Set SSH keys on the template
qm set $VM_ID --sshkey .ssh/id_rsa.pub

#Set user cridentials
qm set $VM_ID --ciuser "gamer0308"
qm set $VM_ID --cipassword $PASSWORD

# Convert the VM to a template
qm template $VM_ID

rm $IMG_NAME
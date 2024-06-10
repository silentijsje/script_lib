#!/bin/bash

# curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/initial.sh | sh


SSH_KEY_NAME="id_ed25519"

# Get the hostname of the PC
HOSTNAME=$(hostname)

sudo apt -y update
sudo apt -y install ansible
sudo apt -y install nano
sudo apt -y install git

git config --global user.name "silentijsje"
git config --global user.email "github@silentijsje"

# Check if the SSH key already exists
if [ ! -f ~/.ssh/${SSH_KEY_NAME} ]; then
    ssh-keygen -t ed25519 -N "" -f ~/.ssh/${SSH_KEY_NAME} -C ${HOSTNAME} -q
    cat ~/.ssh/${SSH_KEY_NAME}.pub
else
    echo "SSH key ~/.ssh/${SSH_KEY_NAME} already exists. Skipping key generation."
fi

curl -fsSL https://tailscale.com/install.sh | sh

mkdir ~/github
cd ~/github
git clone git@github.com:silentijsje/script_lib.git
git clone git@github.com:silentijsje/homelab.git

# Print the hostname
echo "The hostname of this PC is: $HOSTNAME"
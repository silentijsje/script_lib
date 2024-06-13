#!/bin/bash

# curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/initial.sh | sh

SSH_KEY_NAME="id_ed25519"

# Get the hostname of the PC
HOSTNAME=$(hostname)

sudo apt -y update

# Function to check and install a package if it's not already installed
install_if_not_installed() {
    if ! dpkg -l | grep -qw "$1"; then
        sudo apt -y install "$1"
    else
        echo "$1 is already installed. Skipping."
    fi
}

# Install necessary packages
install_if_not_installed "ansible"
install_if_not_installed "nano"
install_if_not_installed "git"

# Configure git
git config --global user.name "silentijsje"
git config --global user.email "github@silentijsje"

# Check if the SSH key already exists
if [ ! -f ~/.ssh/${SSH_KEY_NAME} ]; then
    ssh-keygen -t ed25519 -N "" -f ~/.ssh/${SSH_KEY_NAME} -C ${HOSTNAME} -q
    cat ~/.ssh/${SSH_KEY_NAME}.pub
else
    echo "SSH key ~/.ssh/${SSH_KEY_NAME} already exists. Skipping key generation."
fi

# Install Tailscale if not already installed
if ! command -v tailscale &> /dev/null; then
    curl -fsSL https://tailscale.com/install.sh | sh
else
    echo "Tailscale is already installed. Skipping."
fi

# Clone GitHub repositories
mkdir -p ~/github
cd ~/github
if [ ! -d "script_lib" ]; then
    git clone git@github.com:silentijsje/script_lib.git
else
    echo "script_lib repository already exists. Skipping clone."
fi

if [ ! -d "homelab" ]; then
    git clone git@github.com:silentijsje/homelab.git
else
    echo "homelab repository already exists. Skipping clone."
fi

# Print the hostname
echo "The hostname of this PC is: $HOSTNAME"

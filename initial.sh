#!/bin/bash

# curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/initial.sh | sh

read -p "Enter the name for the ssh key: " SSH_KEY_NAME

sudo apt update
sudo apt install ansible
sudo apt install nano
sudo apt install docker-compose
sudo apt install git
ssh-keygen -t ed25519 -C $SSH_KEY_NAME

curl -fsSL https://tailscale.com/install.sh | sh
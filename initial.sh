#!/bin/bash

# curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/initial.sh | sh

read -p "Enter the name for the ssh key: " SSH_KEY_NAME

sudo apt update
sudo apt install ansible
sudo apt install nano
sudo apt install git

git config --global user.name "silentijsje"
git config --global user.email "github@silentijsje"

ssh-keygen -t ed25519 -N "" -f .ssh/$SSH_KEY_NAME -C $SSH_KEY_NAME -q

curl -fsSL https://tailscale.com/install.sh | sh
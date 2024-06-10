#!/bin/bash

SSH_KEY_NAME=prod-code02

sudo apt update
sudo apt install ansible
sudo apt install nano
sudo apt install docker-compose
sudo apt install git
ssh-keygen -t ed25519 -C $SSH_KEY_NAME

curl -fsSL https://tailscale.com/install.sh | sh
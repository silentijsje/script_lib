#!/bin/bash

# Ensure the system is up to date and install required packages
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Install the HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the key's fingerprint
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add the official HashiCorp repository to the system
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Download the package information from HashiCorp
sudo apt-get update

# Install Terraform
sudo apt-get install -y terraform

# Note: You can also install Vault, Consul, Nomad, and Packer using the same command
# sudo apt-get install -y vault consul nomad packer

# Enable tab completion
touch ~/.bashrc
terraform -install-autocomplete
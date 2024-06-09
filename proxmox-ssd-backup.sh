#!/bin/bash

#Get new script from github
curl -O https://raw.githubusercontent.com/silentijsje/script_lib/main/proxmox-ssd-backup.sh

#Making the script excecuteble
chmod +x proxmox-ssd-backup.sh

#Generates the dat is needed for the future
DATE=$(date '+%F')$

#Also deletes files on the target location
rsync -avzh --delete /ssd/storage/ /mnt/pve/backup/proxmox/ssd/
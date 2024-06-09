#!/bin/bash

#Get new script from github asd
curl -O https://raw.githubusercontent.com/silentijsje/homelab/main/proxmox-ssd-backup.sh?token=GHSAT0AAAAAACSD3VW7QFYGY3EB72TYWYQSZTFW2MQ

#Generates the dat is needed for the future
DATE=$(date '+%F')$

#Also deletes files on the target location
rsync -avzh --delete /ssd/storage/ /mnt/pve/backup/proxmox/ssd/
# General scripts to easy the pain

Source for VM-Template: https://www.learnlinux.tv/proxmox-ve-how-to-build-an-ubuntu-22-04-template-updated-method/

Script to easily create a net template from a newer ubuntu cloud img.
https://cloud-images.ubuntu.com/

Click below to download the VM-Template script
```
curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/vm-template.sh | sh
```

Click below to download the proxmox-ssd-backup script
```
curl -fsSL https://raw.githubusercontent.com/silentijsje/script_lib/main/proxmox-ssd-backup.sh | sh
```

ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 -C prod-storage01 -q

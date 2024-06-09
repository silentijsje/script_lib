#!/bin/bash

# Define the URL of the file in the GitHub repository
GITHUB_FILE_URL="https://raw.githubusercontent.com/silentijsje/script_lib/main/proxmox-ssd-backup.sh"

# Define the local path where the file will be saved
LOCAL_FILE_PATH="/root/backup"

# Define source and destination directories
SOURCE_DIR="/ssd/storage/"
DEST_DIR="/mnt/pve/backup/proxmox/ssd/"

# Rsync options
# -a : archive mode (preserves permissions, timestamps, symbolic links, etc.)
# -v : verbose mode
# -h : human-readable output
# -z : compress files during transfer
# --delete : delete files in the destination that are not in the source
RSYNC_OPTIONS="-avhz --delete"

# Function to print usage
usage() {
    echo "Usage: $0 [source_directory] [destination_directory]"
    echo "If no directories are provided, defaults will be used."
}

# Function to download the file from GitHub
download_file() {
    echo "Downloading the latest version of the file from GitHub..."
    curl -O "$LOCAL_FILE_PATH" "$GITHUB_FILE_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to download the file from GitHub."
        exit 1
    fi
}

#Making the script excecuteble
chmod +x /root/backup/proxmox-ssd-backup.sh

# Check if arguments are provided
if [ "$#" -eq 2 ]; then
    SOURCE_DIR=$1
    DEST_DIR=$2
elif [ "$#" -gt 2 ]; then
    usage
    exit 1
fi

# Run rsync command
rsync $RSYNC_OPTIONS "$SOURCE_DIR" "$DEST_DIR"

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo "Sync completed successfully."
else
    echo "An error occurred during sync."
fi

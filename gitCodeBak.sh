#!/bin/bash

# Define source and destination directories
SOURCE_DIR="/home/gamer0308/github/"
DEST_DIR="/mnt/backup/code/github"

# Rsync options
# -a : archive mode (preserves permissions, timestamps, symbolic links, etc.)
# -v : verbose mode
# -h : human-readable output
# -z : compress files during transfer
# --delete : delete files in the destination that are not in the source
RSYNC_OPTIONS="-avhzqL --delete"

#Frist download the script
cd /home/gamer0308/github/script_lib

git pull

#Making the script excecuteble
chmod +x /home/gamer0308/github/script_lib/gitCodeBak.sh

# Check if arguments are provided
if [ "$#" -eq 2 ]; then
    SOURCE_DIR=$1
    DEST_DIR=$2
elif [ "$#" -gt 2 ]; then
    usage
    exit 1
fi

echo "Start Syncing"

# Run rsync command
rsync $RSYNC_OPTIONS "$SOURCE_DIR" "$DEST_DIR"

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo "Sync completed successfully."
else
    echo "An error occurred during sync."
fi

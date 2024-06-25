#!/bin/bash

# Fetch the remote repository
echo "$(date --utc +%FT%TZ): Fetching remote repository..."
git fetch

# Set the upstream branch
UPSTREAM=${1:-'@{u}'}

# Get the local, remote, and base commit hashes
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

# Check if the local and remote branches are the same
if [ $LOCAL = $REMOTE ]; then
    # If the local and remote branches are the same, the repository is up-to-date
    echo "$(date --utc +%FT%TZ): Up-to-date"
elif [ $LOCAL = $BASE ]; then
    # If the local branch is based on the same commit as the remote branch, changes are detected
    BUILD_VERSION=$(git rev-list HEAD)
    echo "$(date --utc +%FT%TZ): Changes detected, deploying new version $BUILD_VERSION"
    ./deploy.sh
elif [ $REMOTE = $BASE ]; then
    # If the remote branch is based on the same commit as the local branch, local changes are detected
    echo "$(date --utc +%FT%TZ): Local changes detected, stashing..."
    git stash
    ./deploy.sh
else
    # If the local and remote branches have diverged, the repository is in a diverged state
    echo "$(date --utc +%FT%TZ): Diverged"
fi
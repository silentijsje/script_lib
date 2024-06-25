#!/bin/bash

echo "$(date --utc +%FT%TZ): Fetching remote repository..."
git fetch

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

IF [ $LOCAL = $REMOTE ]; THEN
    echo "$(date --utc +%FT%TZ): Up-to-date"
ELIF [ $LOCAL = $BASE ]; THEN
    BUILD_VERSION=$(git rev-list HEAD)
    echo "$(date --utc +%FT%TZ): Changes detected, deploying new version $BUILD_VERSION"
    ./deploy.sh
ELIF [ $REMOTE = $BASE ]; THEN
    echo "$(date --utc +%FT%TZ): Local changes detected, stashing..."
    git stash
    ./deploy.sh
ELSE
    echo "$(date --utc +%FT%TZ): Diverged"
FI
#!/usr/bin/env bash

cd /home/gamer0308/github/homelab
git pull
build_version=$(git rev-parse --short HEAD)
echo "$(date --utc +%FT%TZ): Releasing new server version. $build_version" >> /var/log/server.log
echo "$(date --utc +%FT%TZ): Running build...."
./install.sh
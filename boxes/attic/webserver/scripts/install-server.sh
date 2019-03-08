#!/bin/bash
set -eux -o pipefail

pushd /home/ubuntu

# Set up website directories.
sudo chown -R ubuntu:ubuntu static

# Set up permissions for files.
sudo chown ubuntu:ubuntu go-website

# Make the webserver binary executable.
chmod +x go-website

popd

# Link to the systemd service definition.
sudo systemctl enable go-website.service

#!/bin/bash
set -euxo pipefail

# Install nginx.
apt install -y nginx

# Remove the default sites.
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

# Enable concourse.
ln -s /etc/nginx/sites-available/concourse /etc/nginx/sites-enabled/concourse

# Disable the original nginx systemd file.
rm /etc/systemd/system/multi-user.target.wants/nginx.service

# Enable the new one that we provide.
systemctl enable nginx

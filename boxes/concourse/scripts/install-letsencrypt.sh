#!/bin/bash
set -euxo pipefail

# Install certbot.
add-apt-repository -y ppa:certbot/certbot
apt update
apt install -y certbot

# Enable the service that gets a certificate from letsencrypt.
systemctl enable letsencrypt

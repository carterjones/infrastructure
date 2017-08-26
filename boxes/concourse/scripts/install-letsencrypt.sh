#!/bin/bash
set -euxo pipefail

# Install certbot.
add-apt-repository -y ppa:certbot/certbot
retry 10 30 apt update
apt install -y certbot

# Enable the service that gets a certificate from letsencrypt.
systemctl enable letsencrypt

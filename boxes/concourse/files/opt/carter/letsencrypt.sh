#!/bin/bash
set -euxo pipefail

if [[ ! -f /etc/letsencrypt/live/ci.carterjones.info/fullchain.pem ]]; then
    retry 10 30 letsencrypt certonly \
          --standalone \
          --agree-tos \
          --email spam@carterjones.info \
          --non-interactive \
          -d ci.carterjones.info
fi

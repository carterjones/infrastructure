#!/bin/bash
set -euxo pipefail

# TODO: figure out what to do w/ the non-prod versions of this site (same with blog)
# Maybe just refresh it if there are less than 30 days left.
if [[ ! -f /etc/letsencrypt/live/ci.carterjones.info/fullchain.pem ]]; then
    # letsencrypt certonly \
    #             --standalone \
    #             --agree-tos \
    #             --email spam@carterjones.info \
    #             --non-interactive \
    #             -d ci.carterjones.info
    cert_path=/etc/letsencrypt/live/ci.carterjones.info/
    mkdir -p $cert_path
    cd $cert_path
    aws s3 sync s3://carterjones-terraform-state-prod/ssl/ci.carterjones.info .
fi

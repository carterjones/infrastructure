#!/bin/bash
set -euxo pipefail


# Maybe just refresh it if there are less than 30 days left.
if [[ ! -f /etc/letsencrypt/live/ci.carterjones.info/fullchain.pem ]]; then
    # Pull down the current certificates.
    cert_path=/etc/letsencrypt/live/ci.carterjones.info/
    mkdir -p $cert_path
    cd $cert_path
    aws s3 sync s3://carterjones-terraform-state-prod/ssl/ci.carterjones.info .

    # TODO: on prod, determine if there are less than 30 days left; if so, refresh the certs and upload new certs to S3
    # letsencrypt certonly \
    #             --standalone \
    #             --agree-tos \
    #             --email spam@carterjones.info \
    #             --non-interactive \
    #             -d ci.carterjones.info
fi

#!/bin/bash
set -euxo pipefail

mkdir -p /etc/letsencrypt/live/
pushd /etc/letsencrypt/live/

# email=$(cat /mnt/data/letsencrypt-email.txt)
for domain in test.kelsey.life blog.carterjones.info; do
    if [[ ! -d /etc/letsencrypt/live/$domain ]]; then
        # letsencrypt certonly --standalone --agree-tos --email $email -d $domain
        aws s3 sync "s3://carterjones-terraform-state-${TIER}/ssl/${domain}/" "${domain}"
    fi
done

popd

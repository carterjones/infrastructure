#!/bin/bash

email=$(cat /mnt/data/letsencrypt-email.txt)
for domain in test.kelsey.life blog.carterjones.info; do
    if [[ ! -d /etc/letsencrypt/live/$domain ]]; then
        letsencrypt certonly --standalone --agree-tos --email $email -d $domain
    fi
done

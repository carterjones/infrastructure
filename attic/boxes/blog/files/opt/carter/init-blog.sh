#!/bin/bash
set -euxo pipefail

# Restart the base services.
systemctl restart letsencrypt
systemctl restart nginx

# Set up the ghost config files.
cp /opt/carter/ghost/config-test.kelsey.life.js /mnt/data/test.kelsey.life/config.js
cp /opt/carter/ghost/config-blog.carterjones.info.js /mnt/data/blog.carterjones.info/config.js

# Restart the blogs.
systemctl restart test.kelsey.life
systemctl restart blog.carterjones.info

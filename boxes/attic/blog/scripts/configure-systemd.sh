#!/bin/bash
set -eux -o pipefail

sudo systemctl enable set-hostname.service
sudo systemctl enable format-data-volume.service
sudo systemctl enable letsencrypt.service
sudo systemctl enable blog.carterjones.info.service
sudo systemctl enable test.kelsey.life.service

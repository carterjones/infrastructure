#!/bin/bash
set -eux -o pipefail

sudo systemctl enable set-hostname.service
sudo systemctl enable format-data-volume.service
sudo systemctl enable gitolite.service

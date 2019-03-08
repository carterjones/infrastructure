#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

# Prepare environment.
bash move-files.sh
bash full-upgrade.sh

# Set up gitolite.
bash create-git-user.sh
sudo su -c "bash configure-gitolite.sh" -s /bin/sh git

# Enable services.
bash configure-systemd.sh

popd

#!/bin/bash
set -eux -o pipefail

# Configure the mount.
# For whatever reason, using the simple systemd.mount approach fails miserably
# on this server. I think it's due to some race condition, but after spending a
# few hours hunting it down without success, I'm fine with using this brutish
# approach.
sudo cp fstab /etc/fstab
sudo umount /dev/xvdb
sudo mkdir -p /mnt/data
sudo mount /dev/xvdb

# Copy SSH key material to /etc/ssh so that redeployments don't cause changes in
# SSH keys.
cp -f /mnt/data/sshd/* /etc/ssh/

# Configure golite.
sudo su -c "bash /opt/carter/configure-gitolite.sh" -s /bin/bash git

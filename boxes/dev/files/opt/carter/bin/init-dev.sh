#!/bin/bash
set -eux -o pipefail

# Format the volume if it has no filesystem.
filetype=$(sudo file -s /dev/xvdb)
if [[ "$filetype" == *"data" ]]; then
    sudo mkfs -t ext4 /dev/xvdb
fi

# Make a mount point.
sudo mkdir -p /data

# Save an entry to fstab.
if ! grep -q "^/dev/xvdb" /etc/fstab; then
    sudo bash -c "echo '/dev/xvdb /data ext4 defaults,nofail 0 2' >> /etc/fstab"
else
    sudo sed -i"" "s:/dev/xvdb.*:/dev/xvdb /data ext4 defaults,nofail 0 2:" /etc/fstab
fi

# Mount the volume.
sudo mount -a

# Make a home directory and link it to /home.
sudo mkdir -p /data/home
sudo rm -rf /home
sudo ln -s /data/home /home

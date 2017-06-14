#!/bin/bash
set -eux -o pipefail

cd $HOME

# Make a bin directory for the git user.
mkdir -p bin

# Remove the standard gitolite data.
rm -rf .gitolite
rm -rf .ssh
rm -rf repositories

# Link to the data saved on the state drive.
ln -s /mnt/data/.gitolite
ln -s /mnt/data/.ssh
ln -s /mnt/data/repositories

# Link it to the bin directory.
gitolite/install -ln /home/git/bin

# Set up the admin user.
bin/gitolite setup -pk /opt/carter/carter.pub

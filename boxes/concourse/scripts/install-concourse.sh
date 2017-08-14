#!/bin/bash
set -euxo pipefail

# Install PostgreSQL.
apt install -y \
     postgresql \
     postgresql-contrib

# Set up a concourse user in the database.
sudo -u postgres createuser concourse

# Create the air traffic control database.
sudo -u postgres createdb --owner=concourse atc

# Download concourse and install Concourse.
mkdir -p /tmp/concourse
pushd /tmp/concourse
wget "https://github.com/concourse/concourse/releases/download/v3.4.0/concourse_linux_amd64" -O concourse
chmod +x concourse
sudo mv concourse /usr/local/bin/

# Configure Concourse.
mkdir -p /etc/concourse

# Generate keys for "securely" communicating locally.
ssh-keygen -t rsa -q -N '' -f /etc/concourse/tsa_host_key
ssh-keygen -t rsa -q -N '' -f /etc/concourse/worker_key
ssh-keygen -t rsa -q -N '' -f /etc/concourse/session_signing_key

# Set up the worker key.
cp /etc/concourse/worker_key.pub /etc/concourse/authorized_worker_keys

# Set up a user to run the Concourse web service.
adduser --system --group concourse
chown -R concourse:concourse /etc/concourse
chmod 600 /etc/concourse/*_environment

# Enable the Concourse services.
systemctl enable \
          configure-concourse \
          concourse-web \
          concourse-worker

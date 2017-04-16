#!/bin/bash
set -eux -o pipefail

# Install the Docker GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Check for the Docker GPG key.
sudo apt-key fingerprint 0EBFCD88 | grep -q docker || \
    { echo "Docker fingerprint not found. Exiting."; exit 1; }

# Add the Docker repository.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install Docker.
sudo apt-get update
sudo apt-get install docker-ce -y

# Install docker-compose.
sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#!/bin/bash
set -eux -o pipefail

# Kill any running apt processes.
sudo killall -r apt*

sudo apt-get update
sudo apt-get install -y \
     awscli \
     jq \
     letsencrypt \
     nginx

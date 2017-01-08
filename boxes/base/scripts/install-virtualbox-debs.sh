#!/bin/bash
set -eux -o pipefail

apt-get update
apt-get install -y \
    virtualbox-guest-dkms \
    virtualbox-guest-utils

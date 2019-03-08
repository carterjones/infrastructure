#!/bin/bash
set -eux -o pipefail

sudo killall -r apt*
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" dist-upgrade
sudo apt-get autoremove -y

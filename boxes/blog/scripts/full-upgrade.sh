#!/bin/bash
set -eux -o pipefail

retry 10 30 apt-get update
DEBIAN_FRONTEND=noninteractive retry 10 30 apt-get -y -o Dpkg::Options::="--force-confnew" dist-upgrade
retry 10 30 apt autoremove -y

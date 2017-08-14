#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
retry 10 30 apt-get update
retry 10 30 apt-get -y -o Dpkg::Options::="--force-confnew" dist-upgrade
apt-get autoremove -y

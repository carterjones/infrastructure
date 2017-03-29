#!/bin/bash
set -eux -o pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install \
     nmap \
     nbtscan \
     postgresql \
     virt-what \
     virtualbox-guest-dkms \
     virtualbox-guest-utils \
     virtualbox-guest-x11 \
     wireshark \
     xfce4

#!/bin/bash
set -eux -o pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install \
    postgresql \
    nmap \
    nbtscan \
    virt-what \
    wireshark

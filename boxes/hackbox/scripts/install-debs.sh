#!/bin/bash
set -eux -o pipefail

# Pre-accept the wine installation prompt.
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula select false | sudo debconf-set-selections

sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install \
     awscli \
     nmap \
     nbtscan \
     openvpn \
     postgresql \
     recode \
     virt-what \
     virtualbox-guest-dkms \
     virtualbox-guest-utils \
     virtualbox-guest-x11 \
     wireshark \
     wine \
     xfce4

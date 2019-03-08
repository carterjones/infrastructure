#!/bin/bash
set -eux -o pipefail

pushd /tmp

wget -q "https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb"
sudo dpkg -i vagrant_*.deb
rm vagrant*

popd

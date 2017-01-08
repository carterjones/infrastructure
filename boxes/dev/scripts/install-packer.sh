#!/bin/bash
set -eux -o pipefail

pushd /tmp

wget -q "https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip"
unzip packer_*.zip
sudo mv packer /usr/bin
rm packer*

popd

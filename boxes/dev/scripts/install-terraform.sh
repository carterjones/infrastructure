#!/bin/bash
set -eux -o pipefail

pushd /tmp

wget -q "https://releases.hashicorp.com/terraform/0.8.2/terraform_0.8.2_linux_amd64.zip"
unzip terraform_*.zip
sudo mv terraform /usr/bin
rm terraform*

popd

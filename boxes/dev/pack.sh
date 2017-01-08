#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

bash full-upgrade.sh
bash install-debs.sh
bash move-files.sh
bash install-packer.sh
bash install-terraform.sh
bash install-vagrant.sh
bash configure-home.sh

popd

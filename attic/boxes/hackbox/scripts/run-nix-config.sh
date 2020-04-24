#!/bin/bash
set -eux -o pipefail

pushd /tmp

rm -rf nix-config-master
wget "https://github.com/carterjones/nix-config/archive/master.tar.gz"
tar -xvf master.tar.gz
rm master.tar.gz
cd nix-config-master/
./install

popd

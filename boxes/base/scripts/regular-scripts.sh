#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

bash run-nix-config.sh

popd

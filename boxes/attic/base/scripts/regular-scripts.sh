#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

bash run-nix-config.sh

# Do not use ZSH until my config bugs for it get worked out.
rm -rf $HOME/.use_zsh

popd

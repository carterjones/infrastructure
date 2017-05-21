#!/bin/bash
set -eux -o pipefail

# Run everything from the home directory.
cd $HOME
git clone git://github.com/sitaramc/gitolite

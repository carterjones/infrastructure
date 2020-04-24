#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

bash full-upgrade.sh
bash install-debs.sh
bash move-files.sh
bash install-server.sh
bash configure-nginx.sh

popd

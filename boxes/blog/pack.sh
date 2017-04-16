#!/bin/bash
set -eux -o pipefail

pushd /tmp/scripts

bash move-files.sh
bash full-upgrade.sh
bash install-debs.sh
bash install-docker.sh
bash configure-nginx.sh
bash configure-systemd.sh

popd

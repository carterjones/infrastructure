#!/bin/bash
set -euxo pipefail

pushd /tmp/scripts

bash full-upgrade.sh
bash install-concourse.sh
bash install-nginx.sh
bash install-letsencrypt.sh

popd

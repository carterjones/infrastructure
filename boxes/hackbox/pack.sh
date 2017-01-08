#!/bin/bash
set -ux

export reg_user=$(cut -d: -f1 /etc/passwd | grep -E "(ubuntu|vagrant)")

set -e -o pipefail

pushd /tmp/scripts

bash full-upgrade.sh
bash configure-hostname.sh
bash configure-motd.sh
bash install-debs.sh
bash install-enum4linux.sh
bash install-metasploit.sh

popd

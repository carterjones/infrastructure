#!/bin/bash
set -eux -o pipefail

export reg_user=$(cut -d: -f1 /etc/passwd | grep -E "(ubuntu|vagrant)")

pushd /tmp/scripts

bash full-upgrade.sh
sudo -H -u $reg_user bash -c "/bin/bash /tmp/scripts/regular-scripts.sh"

# We need to run full-upgrade twice because packages somehow don't get
# the upgraded versions installed when installed through other scripts.
bash full-upgrade.sh

popd

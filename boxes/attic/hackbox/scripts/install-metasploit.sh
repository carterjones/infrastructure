#!/bin/bash
set -eux -o pipefail

pushd /tmp

# Install Metasploit.
if [[ ! -f /usr/bin/msfconsole ]]; then
    curl -s "https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb" > msfinstall
    chmod 755 msfinstall
    ./msfinstall
    rm msfinstall
fi

popd

# Enable the PostgreSQL service on boot.
update-rc.d postgresql enable

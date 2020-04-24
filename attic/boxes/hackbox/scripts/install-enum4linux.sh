#!/bin/bash
set -eux -o pipefail

pushd /tmp
wget -q "https://labs.portcullis.co.uk/download/enum4linux-0.8.9.tar.gz"
tar -xvf enum4linux-0.8.9.tar.gz
cp enum4linux-0.8.9/enum4linux.pl /home/$reg_user/bin/enum4linux
chown $reg_user:$reg_user /home/$reg_user/bin/enum4linux
rm -rf enum4linux-0.8.9*
popd

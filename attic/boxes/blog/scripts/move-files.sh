#!/bin/bash
set -eux -o pipefail

tmp_files=/tmp/files
if $(sudo virt-what | grep -q virtualbox); then
    tmp_files=/vagrant/files
fi

pushd $tmp_files
for dir in $(ls); do
    sudo cp -rf $dir /
done
popd

#!/bin/bash
set -eux -o pipefail

pushd /tmp/files

for dir in $(ls); do
    sudo cp -rf $dir /
done

popd

rm -r /tmp/files

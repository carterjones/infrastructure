#!/bin/bash
set -eux -o pipefail

source helpers.sh
paths_of_interest=(
    ci/build-base
    ci/build-website
    boxes/base
    boxes/webserver
)

if check_paths_of_interest $paths_of_interest; then
    pushd ../boxes/webserver/
    bash build.sh
    popd
fi

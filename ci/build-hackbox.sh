#!/bin/bash
set -eux -o pipefail

source helpers.sh
paths_of_interest=(
    ci/build-base
    ci/build-hackbox
    boxes/base
    boxes/hackbox
)

if check_paths_of_interest $paths_of_interest; then
    pushd ../boxes/hackbox/
    bash build.sh
    popd
fi

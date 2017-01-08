#!/bin/bash
set -eux -o pipefail

source helpers.sh
paths_of_interest=(
    ci/build-base
    boxes/base
)

if check_paths_of_interest $paths_of_interest; then
    pushd ../boxes/base/
    bash build.sh
    popd
fi

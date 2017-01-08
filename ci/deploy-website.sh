#!/bin/bash
set -eux -o pipefail

source helpers.sh
paths_of_interest=(
    ci/deploy-website
    boxes/webserver
    terraform/ec2/website
    terraform/sg/world
    terraform/vpc
)

if check_paths_of_interest $paths_of_interest; then
    pushd ../terraform
    for dir in "vpc" "sg/world" "ec2/website"; do
        pushd $dir
        bash configure-state.sh
        terraform apply
        popd
    done
    popd
fi

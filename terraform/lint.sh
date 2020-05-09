#!/bin/bash
set -eux -o pipefail

# Gather a list of all top-level non-module subdirectories.
non_module_dirs=()
while IFS=  read -r -d $'\0'; do
    non_module_dirs+=("$REPLY")
done < <(find . -maxdepth 1 -type d -and -not -name "modules" -print0)

# Initialize all top-level non-module subdirectories.
for dir in "${non_module_dirs[@]}"; do
    pushd "${dir}" || exit 1
    if [[ "${CI}" = "true" ]]; then
        terraform init \
            -backend-config="bucket=carterjones-terraform-state-ci"
    else
        terraform init
    fi
    popd
done

# Run tflint and terraform validate against all top-level non-module
# subdirectories.
for dir in "${non_module_dirs[@]}"; do
    pushd "${dir}" || exit 1
    tflint
    terraform validate
    popd
done

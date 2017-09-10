#!/bin/bash
set -euxo pipefail

# Save the output directory.
out="$PWD/out/"

# Define the utilities to build.
utilities="analyze clean persist trade"

# Build each utility.
for util in $utilities; do
    pushd repo/cmd/$util
    GOOS=linux go build

    # Move the compiled binary to the output directory.
    mv $util $out
    popd
done

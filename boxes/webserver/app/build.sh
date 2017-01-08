#!/bin/bash
set -eux -o pipefail

# Get the directory where this script is stored.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd $DIR

# Install dependencies.
go get -u github.com/gorilla/mux

# Perform the build.
GOOS=linux GOARCH=amd64 go build -o go-website

popd

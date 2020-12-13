#!/bin/bash
set -e

if [[ -z "${1}" ]]; then
    echo "Please supply an image name to release."
    exit 1
fi

image="${1}"
git_hash=$(git rev-parse --verify HEAD)

docker build -f "Dockerfile.${image}" -t "carterjones/${image}:latest" .
docker tag "carterjones/${image}:latest" "carterjones/${image}:${git_hash}"

if [[ $(git branch --show-current) == "main" ]]; then
    docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
    docker push "carterjones/${image}:${git_hash}"
    docker push "carterjones/${image}:latest"
fi

#!/bin/bash
set -e

if [[ -z "${1}" ]]; then
    echo "Please supply an image name to release."
    exit 1
fi

image="${1}"

docker build -f "Dockerfile.${image}" -t "carterjones/${image}:latest" .
docker tag "carterjones/${image}:latest" "carterjones/${image}:${TRAVIS_COMMIT}"

if [[ $(git rev-parse --abbrev-ref HEAD) == "master" ]]; then
    docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
    docker push "carterjones/${image}:${TRAVIS_COMMIT}"
    docker push "carterjones/${image}:latest"
fi

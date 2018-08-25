#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/infra-builder:latest .
docker tag carterjones/infra-builder:latest "carterjones/infra-builder:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/infra-builder:${TRAVIS_COMMIT}"
docker push "carterjones/infra-builder:latest"

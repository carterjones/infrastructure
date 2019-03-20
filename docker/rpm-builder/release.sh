#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/rpm-builder:latest .
docker tag carterjones/rpm-builder:latest "carterjones/rpm-builder:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/rpm-builder:${TRAVIS_COMMIT}"
docker push "carterjones/rpm-builder:latest"

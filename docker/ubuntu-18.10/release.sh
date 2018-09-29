#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/ubuntu-18.10:latest .
docker tag carterjones/ubuntu-18.10:latest "carterjones/ubuntu-18.10:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/ubuntu-18.10:${TRAVIS_COMMIT}"
docker push "carterjones/ubuntu-18.10:latest"

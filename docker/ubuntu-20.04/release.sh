#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/ubuntu-20.04:latest .
docker tag carterjones/ubuntu-20.04:latest "carterjones/ubuntu-20.04:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/ubuntu-20.04:${TRAVIS_COMMIT}"
docker push "carterjones/ubuntu-20.04:latest"

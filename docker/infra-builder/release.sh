#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/arch:latest .
docker tag carterjones/arch:latest "carterjones/arch:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/arch:${TRAVIS_COMMIT}"
docker push "carterjones/arch:latest"

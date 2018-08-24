#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/manjaro:latest .
docker tag carterjones/manjaro:latest "carterjones/manjaro:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/manjaro:${TRAVIS_COMMIT}"
docker push "carterjones/manjaro:latest"

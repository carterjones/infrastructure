#!/bin/bash
set -e

docker build -f Dockerfile -t carterjones/centos-8:latest .
docker tag carterjones/centos-8:latest "carterjones/centos-8:${TRAVIS_COMMIT}"
docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
docker push "carterjones/centos-8:${TRAVIS_COMMIT}"
docker push "carterjones/centos-8:latest"

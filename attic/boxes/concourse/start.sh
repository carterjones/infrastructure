#!/bin/bash
set -eux -o pipefail

export CONCOURSE_EXTERNAL_URL=http://192.168.1.100:8080
docker-compose up

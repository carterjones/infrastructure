#!/bin/bash
set -eux -o pipefail

retry 10 30 apt update
retry 10 30 apt install -y \
     awscli \
     jq \
     letsencrypt \
     nginx

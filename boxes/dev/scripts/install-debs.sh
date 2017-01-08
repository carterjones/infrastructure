#!/bin/bash
set -eux -o pipefail

sudo apt-get install -y \
    awscli \
    unzip \
    virt-what

#!/bin/bash
set -euxo pipefail

retry 10 30 sudo apt install -y \
    awscli

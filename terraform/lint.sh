#!/bin/bash
set -eux -o pipefail

# Run tflint against all subdirectories.
find . -type d | grep -v ".terraform" | xargs -L1 tflint

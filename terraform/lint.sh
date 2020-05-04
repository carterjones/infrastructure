#!/bin/bash

# Run tflint against all subdirectories.
curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip
find . -type d | grep -v ".terraform" | xargs -L1 ./tflint

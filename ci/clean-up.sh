#!/bin/bash
set -eux -o pipefail

# Install virtualenv.
pip3 install virtualenv

# Create the virtual environment.
if ! [[ -d .venv ]]; then
    virtualenv -p python3 .venv
fi

# Activate the virtual environment.
set +u
source .venv/bin/activate
set -u

# Install dependencies.
pip3 -q install boto3 botocore

python3 ./clean-up.py $@

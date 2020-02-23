#!/bin/bash

usage () {
    echo "usage: $0 <ci|dev|prod> (aws-region)"
}

tier=$1
aws_region=${2:-us-west-2}

acceptable_tiers="ci dev prod"

if [[ ! "${acceptable_tiers[*]}" =~ ${tier} ]]; then
    echo "Invalid tier detected: ${tier}"
    echo "Acceptable tiers are: ${acceptable_tiers}"
    usage
    exit 1
fi

set -euxo pipefail

# Delete existing state from disk.
rm -rf .terraform

# Initialize the backend.
terraform init \
          -backend-config="bucket=carterjones-terraform-state-${tier}" \
          -backend-config="region=${aws_region}" \
          -force-copy

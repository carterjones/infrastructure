#!/bin/bash

usage () {
    echo "usage: $0 <ci|dev|prod> (aws-region)"
}

tier=$1

acceptable_tiers="ci dev prod"

if [[ ! "${acceptable_tiers[*]}" =~ ${tier} ]]; then
    echo "Invalid tier detected: ${tier}"
    echo "Acceptable tiers are: ${acceptable_tiers}"
    usage
    exit 1
fi

set -euxo pipefail

# Initialize the backend.
terraform init \
          -backend-config="bucket=carterjones-terraform-state-${tier}" \
          -backend-config="region=us-west-2" \
          -force-copy

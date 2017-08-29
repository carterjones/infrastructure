#!/bin/bash

debug () {
    aws s3 cp s3://carterjones-terraform-state-${tier}/terraform.state .
    cat terraform.state | jq ".modules[0].resources | keys"
    rm terraform.state
}

usage () {
    echo "usage: $0 <ci|dev|prod> <role>"
}

tier=$1
role=$2

acceptable_tiers="ci dev prod"
acceptable_roles="base git blog concourse"

if [[ ! " ${acceptable_tiers[@]} " =~ " ${tier} " ]]; then
    echo "Invalid tier detected: ${tier}"
    echo "Acceptable tiers are: ${acceptable_tiers}"
    usage
    exit 1
fi

if [[ ! " ${acceptable_roles[@]} " =~ " ${role} " ]]; then
    echo "Invalid role detected: ${role}"
    echo "Acceptable roles are: ${acceptable_roles}"
    usage
    exit 1
fi

set -euxo pipefail

debug

aws_region="us-west-2"

# Initialize the backend.
terraform init \
          -backend-config="bucket=carterjones-terraform-state-${tier}" \
          -backend-config="region=${aws_region}" \
          -force-copy

# Destroy the specific EC2 instance associated with this role.
terraform destroy \
          -var "aws_region=${aws_region}" \
          -var "tier=${tier}" \
          -target="aws_instance.${role}" \
          -force

# If this is not prod, then destroy the EIP.
if [[ "${tier}" != prod ]]; then
    terraform destroy \
          -var "aws_region=${aws_region}" \
          -var "tier=${tier}" \
          -target="aws_eip.${role}" \
          -force
fi

debug

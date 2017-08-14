#!/bin/bash

usage="usage: $0 <role>"
role=$1

if [[ "${role}" == "" ]]; then
    echo $usage
    exit 1
fi

set -euxo pipefail

# Prepare variables.
export AWS_DEFAULT_REGION="us-west-2"
main_filter='--filters Name=tag:Name,Values=main'
subnet_id=$(aws ec2 describe-subnets $main_filter | jq -r ".Subnets[0].SubnetId")
vpc_id=$(aws ec2 describe-vpcs $main_filter | jq -r ".Vpcs[0].VpcId")

# Determine the template to use.
if [[ "${role}" == base ]]; then
    template="template-base.json"
else
    template="template-role.json"
fi

# Run packer.
packer build \
    -var "subnet_id=$subnet_id" \
    -var "vpc_id=$vpc_id" \
    -var "role=$role" \
    $template

#!/bin/bash
set -eux -o pipefail

# Prepare variables.
subnet_id=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=main" | \
            jq -r ".Subnets[0].SubnetId")
vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=main" | \
         jq -r ".Vpcs[0].VpcId")

# Run packer.
packer build \
    -var "subnet_id=$subnet_id" \
    -var "vpc_id=$vpc_id" \
    template.json

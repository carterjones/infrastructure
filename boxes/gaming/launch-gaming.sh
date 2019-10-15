#!/bin/bash
set -eux -o pipefail

export AWS_REGION=us-west-2

# Look up the subnet ID.
subnet_id=$(aws ec2 describe-subnets \
            --filters "Name=tag:Name,Values=main-prod" |
            jq -r ".Subnets[0].SubnetId")

# Look up the EIP allocation ID.
eip_id=$(aws ec2 describe-addresses \
         --filters "Name=tag:Name,Values=gaming" |
         jq -r ".Addresses[0].AllocationId")

# Launch the instance.
instance=$(aws ec2 run-instances \
           --launch-template LaunchTemplateName=gaming,Version=4 \
           --subnet-id "${subnet_id}")
instance_id=$(echo "${instance}" | jq -r '.Instances[0].InstanceId')

# Wait for the instance to enter the "running" state.
aws ec2 wait instance-running --instance-ids "${instance_id}"

# Associate the EIP.
aws ec2 associate-address \
    --allocation-id "${eip_id}" \
    --instance-id "${instance_id}"

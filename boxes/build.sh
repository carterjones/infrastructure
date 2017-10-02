#!/bin/bash

usage="usage: $0 <role>"
role=$1

if [[ "${role}" == "" ]]; then
    echo $usage
    exit 1
fi

set -euxo pipefail

is_ci () {
    [[ $(pwd) == /tmp/build/* ]]
}

# Prepare variables.
export AWS_DEFAULT_REGION="us-west-2"
main_filter='--filters Name=tag:Name,Values=main-ci'
subnet_id=$(aws ec2 describe-subnets $main_filter | jq -r ".Subnets[0].SubnetId")
vpc_id=$(aws ec2 describe-vpcs $main_filter | jq -r ".Vpcs[0].VpcId")

# Determine the template to use.
if [[ "${role}" == base ]]; then
    template="template-base.json"
else
    template="template-role.json"
fi

# Run packer and capture its output for processing later.
is_ci && pushd repo/boxes
build_log=/tmp/build-output.log
packer build \
       -var "subnet_id=$subnet_id" \
       -var "vpc_id=$vpc_id" \
       -var "role=$role" \
       $template | tee $build_log
is_ci && popd

# Save the output to a file if this is running on Concourse.
is_ci && {
    # Extract the resulting AMI if one was produced and save it to the output
    # directory.
    produced_ami=$(tail -2 $build_log | head -1)
    cd $(pwd)/ami
    echo $produced_ami > id
}

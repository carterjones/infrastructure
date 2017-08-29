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

# Target an EIP if one exists in the configuration.
target_eip=""
target_eip_association=""
if grep 'resource "aws_eip"' "ec2-${role}.tf"; then
    target_eip="-target=aws_eip.${role}"
    target_eip_association="-target=aws_eip_association.${role}"
fi

# Target an IAM role if one exists in the configuration.
target_iam_role=""
target_iam_role_attachment=""
if grep 'resource "aws_iam_role_policy_attachment"' "ec2-${role}.tf"; then
    target_iam_role="-target=aws_iam_policy.${role}"
    target_iam_role_attachment="-target=aws_iam_role_policy_attachment.${role}"
fi

# Set the key name to use for SSH logins.
var_key_name=""
set +u
if [[ "${KEY_NAME}" != "" ]]; then
    var_key_name="-var key_name=${KEY_NAME}"
fi
set -u

# Use a specific AMI if one has been set via the environment.
set +u
if [[ "${AMI}" != "" ]]; then
    echo "resource \"aws_instance\" \"${role}\" { ami = \"${AMI}\" }" > override.tf
fi
set -u

# Initialize the backend.
./init.sh ${tier}

# Only deploy the specific EC2 instance associated with this role.
terraform apply \
          -var "aws_region=${aws_region}" \
          -var "tier=${tier}" \
          -target="aws_instance.${role}" \
          $var_key_name \
          $target_eip \
          $target_eip_association \
          $target_iam_role \
          $target_iam_role_attachment

# Remove the override file if it was created while running this script.
[[ -f override.tf ]] && rm override.tf

debug

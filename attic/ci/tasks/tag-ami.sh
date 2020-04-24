#!/bin/bash
set -euxo pipefail

# Grab the AMI ID.
pushd ami-in
filename=$(ls | grep -E -v "(url|version)")
region=$(cat $filename | cut -d":" -f 1)
input_ami=$(cat $filename | cut -d" " -f 2)
popd

# Tag the image as passing.
aws ec2 create-tags \
    --resources "${input_ami}" \
    --tags Key=passed_ci,Value=true \
    --region "${region}"

# Set the passed AMI as an output.
pushd ami-out
echo "${input_ami}" > id
popd

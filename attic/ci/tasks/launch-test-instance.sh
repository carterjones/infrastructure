#!/bin/bash
set -euxo pipefail

# Grab the AMI ID and region.
pushd ami-in
filename=$(ls | grep -E -v "(url|version)")
region=$(cat $filename | cut -d":" -f 1)
input_ami=$(cat $filename | cut -d" " -f 2)
popd

# Set the AWS region.
export AWS_DEFAULT_REGION="${region}"

# Prepare the SSH login credential name.
set +e
random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
set -e
key_name="ssh-login-validate-${random_chars}"

# Create a key pair to use to launch a test instance.
aws ec2 create-key-pair --key-name "${key_name}" | jq -r ".KeyMaterial" > /tmp/id_rsa
chmod 0400 /tmp/id_rsa

# Launch an instance using the key pair.
pushd repo/terraform

export AMI="${input_ami}"
export KEY_NAME="${key_name}"
./deploy.sh $TIER $ROLE

# Get the IP of the instance.
public_ip=$(terraform output "ip-${ROLE}")

popd

# Prepare data to pass along the pipeline.
mkdir -p test-instance/data
pushd test-instance/data

# Save the SSH login credentials.
cp /tmp/id_rsa .

# Save the public IP.
echo "${public_ip}" > public_ip

cd ..
tar -cvzf data.tar.gz data
popd

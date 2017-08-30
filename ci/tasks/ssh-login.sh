#!/bin/bash
set -euxo pipefail

# Grab the AMI ID and region.
pushd ami-in
filename=$(ls | grep -E -v "(url|version)")
region=$(cat $filename | cut -d":" -f 1)
input_ami=$(cat $filename | cut -d" " -f 2)

# Set the AWS region.
export AWS_DEFAULT_REGION="${region}"

popd

# Grab the instance data.
pushd test-instance
tar -xvf test-instance-data.tar.gz

# Set up the SSH private key login file.
mv data/id_rsa /tmp/id_rsa
chmod 0400 /tmp/id_rsa

# Get the public IP.
public_ip=$(cat data/public_ip)

popd

# Make a helper function that attempts to log into the system.
try_ssh_login () {
    ssh -i /tmp/id_rsa \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        "ubuntu@${public_ip}" \
        ls
}

# Try to log into the instance 10 times, waiting 30 seconds between retries.
retry 10 30 try_ssh_login

if [[ "$result" != 0 ]]; then
    echo "Unable to SSH into the system."
    exit 1
fi

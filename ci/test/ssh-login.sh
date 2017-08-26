#!/bin/bash
set -euxo pipefail

# Grab the AMI ID.
pushd ami-in
filename=$(ls | grep -E -v "(url|version)")
# TODO: Eventually make some logic around using other regions. This just assumes us-west-2.
input_ami=$(cat $filename | cut -d" " -f 2)
popd

# Prepare the SSH login credential name.
set +e
random_chars=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
set -e
key_name="ssh-login-validate-${random_chars}"

export AWS_DEFAULT_REGION="us-west-2"

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

# Try to log into the instance 10 times, waiting 30 seconds between retries.
try_ssh_login () {
    ssh -i /tmp/id_rsa \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        "ubuntu@${public_ip}" \
        ls
}
for i in {1..10}; do
    sleep 5
    set +e
    try_ssh_login
    result=$?
    set -e
    if [[ "$result" == 0 ]]; then
        break
    fi
done

if [[ "$result" != 0 ]]; then
    echo "Unable to SSH into the system."
    exit 1
fi

# Tag the image as passing.
aws ec2 create-tags --resources "${input_ami}" --tags Key=passed_ci,Value=true

# Destroy the instance.
./destroy.sh $TIER $ROLE

popd

# Delete the key pair.
aws ec2 delete-key-pair --key-name "${key_name}"

# Set the passed AMI as an output.
pushd ami-out
echo "${input_ami}" > id
pwd
ls -l
popd

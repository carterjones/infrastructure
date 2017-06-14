#!/bin/bash
set -x

# Get the blog IP.
ip=$(terraform output ip)

# Turn off the git server. This dismounts volumes.
ssh -oStrictHostKeyChecking=no "ubuntu@${ip}" 'sudo poweroff'

# Wait for the system to dismount the volumes.
sleep 15s

# Apply the updates.
terraform apply

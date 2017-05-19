#!/bin/bash
set -x

# Get the blog IP.
ip=$(terraform output ip)

# Turn off Docker, wait for processes to finish, and make a backup.
ssh -oStrictHostKeyChecking=no "ubuntu@${ip}" 'sudo killall docker-proxy; sleep 10s; generate-backup'

# Copy the backup to this system.
scp "ubuntu@${ip}:~/backup.tar.gz" .

# Turn off the blog. This dismounts volumes.
ssh -oStrictHostKeyChecking=no "ubuntu@${ip}" 'sudo poweroff'

# Wait for the system to dismount the volumes.
sleep 15s

# Apply the updates.
terraform apply

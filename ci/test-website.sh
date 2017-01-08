#!/bin/bash
set -eux -o pipefail

# Get the IP of the deployed web server.
public_ip=$(aws ec2 describe-instances --filters "Name=tag:role,Values=go-website" "Name=instance-state-name,Values=running" | \
            jq -r ".Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicIp")

# Verify that content is being served without error.
status_code=$(curl -s -o /dev/null -w "%{http_code}" http://$public_ip/)
test "$status_code" = "200"

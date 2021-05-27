#!/usr/bin/env bash

aws ec2 stop-instances --instance-ids "$(terraform output -raw instance_id)"

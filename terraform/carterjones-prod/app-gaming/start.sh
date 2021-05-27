#!/usr/bin/env bash

aws ec2 start-instances --instance-ids "$(terraform output -raw instance_id)"

#!/bin/bash

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=carterjones-terraform-state-prod" \
    -backend-config="key=vpc/terraform.tfstate" \
    -backend-config="region=us-west-2"

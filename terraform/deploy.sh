#!/bin/bash

usage="usage: $0 <role>"
role=$1

if [[ "${role}" == "" ]]; then
    echo $usage
    exit 1
fi

set -euxo pipefail

# Only deploy the specific EC2 instance associated with this role.
terraform apply \
          -target="aws_instance.${role}" \
          -target="aws_eip_association.${role}"

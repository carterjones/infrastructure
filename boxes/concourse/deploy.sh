#!/bin/bash
set -euxo pipefail

pushd ../../terraform
terraform apply -target=aws_instance.concourse -target=aws_eip_association.concourse
popd

#!/bin/bash
set -euxo pipefail

ssh-keygen -f "$HOME/.ssh/known_hosts" -R ci.carterjones.info
scp web_environment.backup ubuntu@ci.carterjones.info:/tmp/web_environment
ssh ubuntu@ci.carterjones.info "sudo mv /tmp/web_environment /etc/concourse/"
ssh ubuntu@ci.carterjones.info "sudo systemctl restart concourse-web concourse-worker"

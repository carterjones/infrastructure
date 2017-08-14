#!/bin/bash
set -euxo pipefail

# Regular builds.
fly -t ci set-pipeline -n -p base -c pipeline-base.yml
fly -t ci set-pipeline -n -p blog -c pipeline-blog.yml
fly -t ci set-pipeline -n -p concourse -c pipeline-concourse.yml
fly -t ci set-pipeline -n -p git -c pipeline-git.yml
fly -t ci set-pipeline -n -p clean -c pipeline-clean.yml

# Manual builds & deploys.
fly -t ci set-pipeline -n -p manual -c pipeline-manual.yml

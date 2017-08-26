#!/bin/bash
set -euxo pipefail

# Regular builds.
fly -t ci set-pipeline -n -p base -c pipeline-base.yml -l secrets.yml
fly -t ci set-pipeline -n -p blog -c pipeline-blog.yml -l secrets.yml
fly -t ci set-pipeline -n -p concourse -c pipeline-concourse.yml -l secrets.yml
fly -t ci set-pipeline -n -p git -c pipeline-git.yml -l secrets.yml
fly -t ci set-pipeline -n -p clean -c pipeline-clean.yml -l secrets.yml

# Manual builds & deploys.
fly -t ci set-pipeline -n -p manual -c pipeline-manual.yml

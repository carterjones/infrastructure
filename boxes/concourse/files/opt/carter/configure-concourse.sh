#!/bin/bash
set -euxo pipefail

# Generate a random username and password to use for logging into Concourse.
set +e
CONCOURSE_USERNAME=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c50)
CONCOURSE_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c50)
set -e
sed -i "s/%%CONCOURSE_USERNAME%%/${CONCOURSE_USERNAME}/" /etc/concourse/web_environment
sed -i "s/%%CONCOURSE_PASSWORD%%/${CONCOURSE_PASSWORD}/" /etc/concourse/web_environment

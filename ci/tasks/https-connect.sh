#!/bin/bash
set -euxo pipefail

# Grab the instance data.
pushd test-instance
tar -xvf test-instance-data.tar.gz

# Get the public IP.
public_ip=$(cat data/public_ip)

popd

# We ignore the certificate because the CI cert is messed up and because we are
# using the IP rather than a hostname. The purpose of this test is just to make
# sure we get a 200 over HTTPS.
retry 10 30 curl -s -I -k https://${public_ip} -H "Host: blog.carterjones.info" | grep "200 OK"
retry 10 30 curl -s -I -k https://${public_ip} -H "Host: test.kelsey.life" | grep "200 OK"

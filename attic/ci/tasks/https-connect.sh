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
# Try to connect to both instances 20 times, waiting 5 seconds between retries.
# Note: we do it this way rather than by using curl's --retry because this
# provides much better debugging information.
for host in blog.carterjones.info test.kelsey.life; do
    for i in {1..20}; do
        sleep 5
        set +e
        curl -I -k "https://${public_ip}" -H "Host: blog.carterjones.info" --connect-timeout 3
        result=$?
        set -e
        if [[ "$result" == 0 ]]; then
            break
        fi
    done
done

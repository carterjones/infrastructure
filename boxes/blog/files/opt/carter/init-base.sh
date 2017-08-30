#!/bin/bash
set -euxo pipefail

TIER=$1

echo TIER="${TIER}" >> /etc/environment

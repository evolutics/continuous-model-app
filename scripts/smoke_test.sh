#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

curl --fail --max-time 3 --retry 99 --retry-connrefused --retry-max-time 150 \
  --show-error http://"${KEREK_IP}":8080

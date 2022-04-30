#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

curl --fail --show-error "http://$1:8080"

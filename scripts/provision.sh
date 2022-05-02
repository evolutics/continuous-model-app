#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

install_kubernetes() {
  curl --fail --location --silent https://get.k3s.io | sh -
}

set_up_storage() {
  mkdir /data
}

main() {
  install_kubernetes
  set_up_storage
}

main "$@"

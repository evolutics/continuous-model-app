#!/bin/bash

set -o errexit -o nounset -o pipefail

main() {
  local -r script_folder="$(dirname "$(readlink --canonicalize "$0")")"
  cd "$(dirname "${script_folder}")"

  if ! minikube status; then
    minikube start
  fi

  skaffold dev --port-forward
}

main "$@"

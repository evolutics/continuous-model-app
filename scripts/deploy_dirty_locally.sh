#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

main() {
  local -r script_folder="$(dirname "$(readlink --canonicalize "$0")")"
  cd "$(dirname "${script_folder}")"

  export APP_VERSION="${RANDOM}"

  if ! minikube status; then
    minikube start
  fi

  # shellcheck disable=SC2046
  eval $(minikube docker-env)
  scripts/build.sh

  kubectl apply --kustomize orchestration
}

main "$@"

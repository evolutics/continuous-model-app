#!/bin/bash

set -o errexit -o nounset -o pipefail

cd -- "$(dirname -- "$0")/.."

if ! minikube status; then
  minikube start
fi

skaffold dev --port-forward

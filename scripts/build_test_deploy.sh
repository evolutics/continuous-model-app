#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

build_test_deploy_virtually() {
  vagrant destroy --force
  local -r vm_ip='192.168.63.63'
  IP="${vm_ip}" vagrant up

  local -r kubeconfig_file="${PWD}/.kubeconfig/staging"
  vagrant ssh --command 'sudo cat /etc/rancher/k3s/k3s.yaml' \
    | sed "s/127\.0\.0\.1/${vm_ip}/g" >"${kubeconfig_file}"
  remind_of_registry_forward 'staging'

  skaffold run --kubeconfig "${kubeconfig_file}"

  scripts/smoke_test.sh "${vm_ip}"
  scripts/acceptance_test.sh "${vm_ip}"
}

remind_of_registry_forward() {
  echo "TODO: Forward $1 to registry: vagrant ssh -- -R 5000:localhost:5000"
  read -r
}

deploy_test_production() {
  remind_of_registry_forward 'production'
  skaffold run --kubeconfig "${PWD}/.kubeconfig/production"
  scripts/smoke_test.sh '192.168.62.62'
}

main() {
  local -r script_folder="$(dirname "$(readlink --canonicalize "$0")")"
  cd "$(dirname "${script_folder}")"

  scripts/basic_test.sh
  build_test_deploy_virtually
  deploy_test_production
}

main "$@"

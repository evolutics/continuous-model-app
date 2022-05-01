#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

build_test_deploy_virtually() {
  vagrant destroy --force
  local -r vm_ip='192.168.63.63'
  IP="${vm_ip}" vagrant up

  local -r kubeconfig_file="${PWD}/.kubeconfig/staging"
  scripts/provision.sh --ip "${vm_ip}" \
    --local-path "${kubeconfig_file}" \
    --ssh-key .vagrant/machines/default/virtualbox/private_key --user vagrant

  echo 'TODO: Keep forward to registry: vagrant ssh -- -R 5000:localhost:5000'
  read -r

  skaffold run --kubeconfig "${kubeconfig_file}"

  scripts/smoke_test.sh "${vm_ip}"
  scripts/acceptance_test.sh "${vm_ip}"
}

deploy_test_production() {
  # TODO: Deploy, then smoke test.
  echo 'TODO'
}

main() {
  local -r script_folder="$(dirname "$(readlink --canonicalize "$0")")"
  cd "$(dirname "${script_folder}")"

  scripts/basic_test.sh
  build_test_deploy_virtually
  deploy_test_production
}

main "$@"

#!/bin/bash

set -o errexit -o nounset -o pipefail

cd -- "$(dirname -- "$0")/.."

docker run --entrypoint sh --rm --volume "${PWD}":/workdir \
  evolutics/travel-kit:0.8.0 -c \
  'git ls-files -z | xargs -0 travel-kit check --skip Pylint --'

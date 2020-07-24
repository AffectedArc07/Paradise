#!/bin/bash
set -euo pipefail

# Script to install PHPEnv for GitHub actions
curl -L http://git.io/phpenv-installer | sudo bash
# Add it to path
export PHPENV_ROOT="/home/runner/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

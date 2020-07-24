#!/bin/bash
set -euo pipefail

source _build_dependencies.sh

# Script to install PHPEnv for GitHub actions
curl -L http://git.io/phpenv-installer | sudo bash
$HOME/.phpenv/bin/phpenv install $PHP_VERSION

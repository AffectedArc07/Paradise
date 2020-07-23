#!/bin/bash
set -euo pipefail

source _build_dependencies.sh

source ~/.nvm/nvm.sh
nvm install $NODE_VERSION
nvm use $NODE_VERSION
npm install --global yarn

pip install --user PyYaml -q
pip install --user beautifulsoup4 -q

# This line is a check to see if were running under GitHub actions, and if we are, set the PHP env folder
[ -d "/home/runner" ] && export PHPENV_ROOT="/home/runner/.phpenv"
phpenv global $PHP_VERSION

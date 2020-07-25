#!/bin/bash
set -euo pipefail

source _build_dependencies.sh

source ~/.nvm/nvm.sh
nvm install $NODE_VERSION
nvm use $NODE_VERSION
sudo npm install --global yarn

pip install --user PyYaml -q
pip install --user beautifulsoup4 -q

# /home/runner is created if this is running on GitHub actions, but not on travis
# Therefore this line will only run on Travis
[ ! -d "/home/runner" ] && phpenv global $PHP_VERSION

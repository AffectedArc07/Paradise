#!/bin/bash
set -euo pipefail

# Script to install PHPEnv for GitHub actions
curl -L http://git.io/phpenv-installer | sudo bash
# Add it to path
echo 'export PATH="$HOME/.phpenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(phpenv init -)"' >> ~/.bash_profile
exec $SHELL -l

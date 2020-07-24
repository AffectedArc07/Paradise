#!/bin/bash
set -euo pipefail

cd nano
source ~/.nvm/nvm.sh
sudo npm install -g gulp-cli
sudo npm install --loglevel=error --force
node node_modules/gulp/bin/gulp.js --require less-loader
cd ..

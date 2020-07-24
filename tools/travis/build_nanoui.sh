#!/bin/bash
set -euo pipefail

cd nano
source ~/.nvm/nvm.sh
sudo npm install -g gulp-cli --force
sudo npm install --loglevel=error
node node_modules/gulp/bin/gulp.js --require less-loader
cd ..

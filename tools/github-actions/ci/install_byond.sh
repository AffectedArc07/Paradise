#!/bin/bash
set -euo pipefail

# Script to install BYOND in GitHub actions

# Grab libraries
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt install libstdc++6:i386

# Grab BYOND versions
source _build_dependencies.sh

mkdir -p "$HOME/BYOND"
cd "$HOME/BYOND"
curl "http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip" -o byond.zip
unzip byond.zip
rm byond.zip
cd byond
make here
cd ~/
export LD_LIBRARY_PATH="/usr/lib"
source ~/BYOND/byond/bin/byondsetup
echo "BYOND Installed"

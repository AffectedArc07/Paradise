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
echo "$BYOND_MAJOR.$BYOND_MINOR" > "$HOME/BYOND/version.txt"
cd ~/

echo "::set-env name=BYOND_SYSTEM::/home/runner/BYOND/byond"
echo "::set-env name=PATH::/home/runner/BYOND/byond/bin:$PATH"
echo "::set-env name=LD_LIBRARY_PATH::/home/runner/BYOND/byond/bin:$LD_LIBRARY_PATH"
echo "::set-env name=MANPATH::/home/runner/BYOND/byond/man:$MANPATH"

source ~/BYOND/byond/bin/byondsetup
echo "BYOND Installed"

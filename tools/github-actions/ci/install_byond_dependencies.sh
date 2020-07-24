# Script to install BYOND libraries for GitHub actions
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt install libstdc++6:i386

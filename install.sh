#!/bin/bash 

echo "installing requirements..."
sudo apt update
sudo apt-get install -y git
echo "cloning repo..."
git clone https://github.com/sebstec/ubuntu-intune.git
cd ./ubuntu-intune/install-intune
sudo ./install-intune-portal.sh

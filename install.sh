#!/bin/bash 

echo "installing requirements..."
apt update
apt-get install -y git
echo "cloning repo..."
git clone https://github.com/sebstec/ubuntu-intune.git
cd ./ubuntu-intune/install-intune
./install-intune-portal.sh

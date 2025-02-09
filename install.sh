#!/bin/bash 

echo "installing requirements..."
sudo apt update
sudo apt-get install -y git
echo "cloning repo..."
git clone https://github.com/sebstec/ubuntu-intune.git
cd ./ubuntu-intune/install-intune
sudo ./install-intune-portal.sh
sudo ./setup-polkit-rules.sh
read -p 'should v4l2loopback-dkms and linux headers be installed (for obs virtualcam, requires manual interaction if secure boot is enabled)? y/N:' installloopbackvar
if [[ $installloopbackvar = 'y' ]]; 
then
	echo "installing obs virtualcam dependencies"
	sudo apt install -y linux-headers-$(uname -r) v4l2loopback-dkms
else
	echo "skipping installation of dependencies for obs virtualcam!"
fi


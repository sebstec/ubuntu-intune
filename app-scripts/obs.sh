#!/bin/bash
# obs
add-apt-repository ppa:obsproject/obs-studio
apt update
apt install ffmpeg obs-studio
# background removal plugin
wget "https://github.com/locaal-ai/obs-backgroundremoval/releases/download/1.1.13/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb"
dpkg -i obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
rm obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
# loopback to get virtual cam
apt install linux-headers-$(uname -r) v4l2loopback-dkms

#!/bin/bash
app=obs
script=install-$app
output=intune-script-logs/$script-script-output.txt
log=/home/$(id -u -n 1000)/$output

if ! (id -u -n 1000);
then
        mkdir -p /tmp/intune-script-logs
        echo "user with id 1000 does not exist!" >> /tmp/$output
        exit 1
fi
mkdir -p /home/$(id -u -n 1000)/intune-script-logs
echo $(date -Iseconds) >> $log
echo "hello-from-intune: $script" >> $log
apt-get update
if [ "$(dpkg -l | awk '/obs/ {print }'|wc -l)" -ge 1 ]; then
  echo "$app already installed" >> $log
fi
#else
  # obs
  add-apt-repository -y ppa:obsproject/obs-studio
  apt update
  apt install -y ffmpeg obs-studio
  # background removal plugin
  wget "https://github.com/locaal-ai/obs-backgroundremoval/releases/download/1.1.13/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb" -O ./obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  dpkg -i obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  # rm obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  # loopback to get virtual cam
  # should be installed with intune-portal, as it requires manual interaction if secure-boot is enabled
  # apt install -y linux-headers-$(uname -r) v4l2loopback-dkms
  echo "$app successfully installed" >> $log
#fi
echo -e "bye-from-intune\n" >> $log

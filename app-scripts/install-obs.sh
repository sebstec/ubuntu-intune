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
  echo "installing curl..." >> $log
  apt install -y curl
  echo "curling obs source key..." >> $log
  curl https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xbc7345f522079769f5bbe987efc71127f425e228 | gpg --dearmor > obs.gpg
  echo "installing obs source key..." >> $log
  install -o root -g root -m 644 obs.gpg /etc/apt/trusted.gpg.d/
  echo "installing source..." >> $log
  echo "deb https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main
deb-src https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main" > /etc/apt/sources.list.d/obs.list
  echo "apt updating and installing ffmpeg and obs-studio..." >> $log
  apt update
  apt install -y ffmpeg obs-studio
  # background removal plugin
  echo "getting obs backgroundremoval plugin installer..." >> $log
  curl https://github.com/locaal-ai/obs-backgroundremoval/releases/download/1.1.13/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb -LJ -o /tmp/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  echo "installing obs backgroundremoval plugin..." >> $log
  yes | dpkg -i /tmp/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  echo "removing obs backgroundremoval plugin installer..." >> $log
  rm /tmp/obs-backgroundremoval-1.1.13-x86_64-linux-gnu.deb
  # loopback to get virtual cam
  # should be installed with intune-portal, as it requires manual interaction if secure-boot is enabled
  # apt install -y linux-headers-$(uname -r) v4l2loopback-dkms
  echo "$app successfully installed" >> $log
#fi
echo -e "bye-from-intune\n" >> $log

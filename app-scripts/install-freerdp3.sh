#!/bin/bash
app=freerdp3
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
if [ "$(dpkg -l | awk '/xfreerdp/ {print }'|wc -l)" -ge 1 ]; then
  echo "$app already installed" >> $log
else
  flatpak install -y com.freerdp.FreeRDP
  echo "$app successfully installed" >> $log
fi
echo -e "bye-from-intune\n" >> $log

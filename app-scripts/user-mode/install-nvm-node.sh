#!/bin/bash
# better run this manually xD
#app=nvm-node
#script=install-$app
#output=intune-script-logs/$script-script-output.txt
#log=/home/$(id -u -n 1000)/$output
#
#if ! (id -u -n 1000);
#then
#        mkdir -p /tmp/intune-script-logs
#        echo "user with id 1000 does not exist!" >> /tmp/$output
#        exit 1
#fi
#mkdir -p /home/$(id -u -n 1000)/intune-script-logs
#echo $(date -Iseconds) >> $log
#echo "hello-from-intune: $script" >> $log
#apt-get update
if [ "$(nvm | grep -ic "node version manager")" -e 1 ]; then
  echo "$app already installed" >> $log
else
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  source ~/.bashrc
  nvm install 22
  echo "$app successfully installed" >> $log
fi
#echo -e "bye-from-intune\n" >> $log

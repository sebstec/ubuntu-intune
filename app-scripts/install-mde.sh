#!/bin/bash
app=mdatp
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
if [ "$(dpkg -l | awk '/mdatp/ {print }'|wc -l)" -ge 1 ]; then
  echo "$app already installed" >> $log
fi
#else
  mkdir -p /home/$(id -u -n 1000)/mde
  cd /home/$(id -u -n 1000)/mde
  wget https://raw.githubusercontent.com/microsoft/mdatp-xplat/refs/heads/master/linux/installation/mde_installer.sh -O ./mde_installer.sh
  chmod 755 ./mde_installer.sh
  if [ "$(ls | grep -ic 'MicrosoftDefenderATPOnboardingLinuxServer.py')" -le 0 ]; 
  then
    echo "put the onboarding python script downloaded from ms defender portal to this directory: $(pwd)!"  >> $log
  else
    ./mde_installer.sh --install --channel prod --onboard ./MicrosoftDefenderATPOnboardingLinuxServer.py --tag GROUP Coders --min_req -y
    mdatp config real-time-protection --value enabled
    mdatp health --field real_time_protection_enabled >> $log
    echo "$app successfully installed" >> $log
  fi
#fi
echo -e "bye-from-intune\n" >> $log

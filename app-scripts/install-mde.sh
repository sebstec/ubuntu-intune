#!/bin/bash
wget https://github.com/microsoft/mdatp-xplat/blob/master/linux/installation/mde_installer.sh
chmod 755 ./mde_installer.sh
read -p 'put the onboarding python script downloaded from ms defender portal to this directory! then press a key...'
sudo ./mde_installer.sh --install --channel prod --onboard ./MicrosoftDefenderATPOnboardingLinuxServer.py --tag GROUP Coders --min_req -y
mdatp health --field real_time_protection_enabled
curl -o ~/Downloads/eicar.com.txt https://www.eicar.org/download/eicar.com.txt

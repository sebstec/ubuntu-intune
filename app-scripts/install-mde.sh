#!/bin/bash
wget https://raw.githubusercontent.com/microsoft/mdatp-xplat/refs/heads/master/linux/installation/mde_installer.sh
chmod 755 ./mde_installer.sh
read -p 'put the onboarding python script downloaded from ms defender portal to this directory! then press a key...'
./mde_installer.sh --install --channel prod --onboard ./MicrosoftDefenderATPOnboardingLinuxServer.py --tag GROUP Coders --min_req -y
mdatp config real-time-protection --value enabled
mdatp health --field real_time_protection_enabled
curl -o ~/Downloads/eicar.com.txt https://www.eicar.org/download/eicar.com.txt

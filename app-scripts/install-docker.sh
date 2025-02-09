#!/bin/bash 
script=install-docker
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
if [ "$(dpkg -l | awk '/docker-ce/ {print }'|wc -l)" -ge 1 ]; then
  echo "docker already installed" >> $log
fi
#else
  # Add Docker's official GPG key:
  apt-get install -y ca-certificates curl
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  
  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  systemctl enable docker
  echo "docker successfully installed" >> $log
  echo "installing rootless mode" >> $log 
  apt-get install -y dbus-user-session 
  echo "installed dbus-user-session, relog required!" >> $log
  apt-get install -y uidmap 
  apt-get install -y docker-ce-rootless-extras 
  systemctl disable --now docker.service docker.socket 
  rm /var/run/docker.sock 
#fi 
echo -e "bye-from-intune\n" >> $log



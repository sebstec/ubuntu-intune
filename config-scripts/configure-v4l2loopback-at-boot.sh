#!/bin/bash
script=configure-v4l2loopback-at-boot
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
echo "hello-from-intune: configuring v4l2loopback at boot..." >> $log
echo "v4l2loopback" > /etc/modules-load.d/v4l2loopback.conf
# also tested working
#echo "options v4l2loopback video_nr=9 card_label=Video-Loopback exclusive_caps=1" > /etc/modprobe.d/v4l2loopback.conf
echo "options v4l2loopback devices=1 video_nr=10 card_label=\"OBS Cam\" exclusive_caps=1" > /etc/modprobe.d/v4l2loopback.conf
# update-initramfs -c -k $(uname -r)
echo -e "bye-from-intune\n" >> $log

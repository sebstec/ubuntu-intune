#!/bin/bash
script=echo-test
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
echo "hello-from-intune: echo" >> $log
echo -e "bye-from-intune\n" >> $log

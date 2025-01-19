#!/bin/bash
script=check-wheel
output=intune-script-logs/$script-script-output.txt
log=/home/$(id -u -n 1000)/$output

if ! (id -u -n 1000 1>/dev/null);
then
        mkdir -p /tmp/intune-script-logs
        echo "user with id 1000 does not exist!" >> /tmp/$output
        exit 1
fi
mkdir -p /home/$(id -u -n 1000)/intune-script-logs
echo $(date -Iseconds) >> $log
echo "hello-from-intune: checking groups of active processes..." >> $log
list=$(ps -eo user,uid | awk 'NR>1 && ++seen[$2]==1{print $1}')
for u in $list; 
do
	count=$(groups $u 2>/dev/null | grep -icE 'wheel|sudo')
	if [ "$count" -gt 0 ];
	then
		echo "alert: found active processes of wheel user: $u!" >> $log
		echo -n "{"
		echo -n "\"wheelusers\": 1"
		echo "}"
		exit 0
	fi;
done
echo "finished: no process by users from wheel found" >> $log
echo -e "bye-from-intune\n" >> $log
echo -n "{"
echo -n "\"wheelusers\": 0"
echo "}"

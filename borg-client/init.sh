#!/bin/bash
echo "Preparing ProxyJump"
if [ -n "$ssh_proxy_jump"]
then
	ssh_proxy_jump_full="ProxyJump $ssh_proxy_jump"
fi
echo "Running envsubst over all important files"
cd /borg/config.pre
find -type f |while read -r file
do
	echo "Running on $file"
	cat $file
	echo "changes"
	cat $file |envsubst > /borg/config/$file
	cat $file
	
done
echo "starting crontab"
cron -f
#tail -f /var/log/cron.log
#TODO check if cron has died

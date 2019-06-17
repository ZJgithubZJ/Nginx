#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

while true
do
	if [[ $(pidof nginx| wc -l) -eq 0 ]];then
		echo "$(date '+%F %T') [error] nginx is down." >> /usr/local/nginx/conf/vhosts/monitor-nginx.log
		config_backdir=/usr/local/nginx/conf/vhosts/back-$(date '+%Y%m%d')
		mkdir -p ${config_backdir}
#		cp -a /usr/local/nginx/conf/vhosts/wdtres.gamedreamer.com.tw.conf /usr/local/nginx/conf/vhosts/wdtcdn.gamedreamer.com.tw.conf  /usr/local/nginx/conf/vhosts/whitelist.txt /usr/local/nginx/conf/vhosts/back-$(date '+%Y%m%d')/
		cp -a /usr/local/nginx/conf/vhosts/*.conf  /usr/local/nginx/conf/vhosts/whitelist.txt ${config_backdir}/
		cp -a /usr/local/nginx/conf/vhosts/back-20170915/* /usr/local/nginx/conf/vhosts/
		echo "$(date '+%F %T') [info] nginx starting..." >> /usr/local/nginx/conf/vhosts/monitor-nginx.log
		/etc/init.d/nginx start
	else
		break
	fi
done

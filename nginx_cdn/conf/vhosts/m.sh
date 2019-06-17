#!/bin/bash

if [[ $(pidof nginx| wc -l) -eq 0 ]];then
	echo "$(date '+%F %T') [error] nginx is down." >> /usr/local/nginx/conf/vhosts/nginx-monitor.log
	mkdir -p /usr/local/nginx/conf/vhosts/back-$(date '+%Y%m%d')/
	cp -a /usr/local/nginx/conf/vhosts/wdtres.gamedreamer.com.tw.conf /usr/local/nginx/conf/vhosts/wdtcdn.gamedreamer.com.tw.conf  /usr/local/nginx/conf/vhosts/whitelist.txt /usr/local/nginx/conf/vhosts/back-$(date '+%Y%m%d')/
	cp -a /usr/local/nginx/conf/vhosts/back-20170915/* /usr/local/nginx/conf/vhosts/
	echo "$(date '+%F %T') [info] nginx starting..." >> /usr/local/nginx/conf/vhosts/nginx-monitor.log
	/etc/init.d/nginx start
fi



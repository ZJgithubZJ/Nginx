#/bin/bash

# nginx日誌
#log=/var/log/nginx/wdtcdn.gamedreamer.com.tw.log
log="/usr/local/nginx_logs/wdtcdn.gamedreamer.com.tw_access.log /usr/local/nginx_logs/wdthcdn.gamedreamer.co.th_access.log"
# 訪問列表
whitelist=/usr/local/nginx/conf/vhosts/whitelist.txt
# 取出惡意訪問IP,并添加deny策略
for bad_ip in $(cat $log| grep -Ei 'scripts/setup.php HTTP/1.1|:80/phpmyadmin|/phpmyadmin HTTP/1.1|:80/pma|:80/phppma|:80/phpmy|myadmin/ HTTP/1.1|:80/mysql/|:80/db/|:80/MyAdmin/|:80/shopdb/|:80/database/ HTTP/1.1|:80/sqlmanager/|:80/mysqlmanager/|:80/php-myadmin/|:80/mysqladmin/|:80/mysql-admin/|:80/admin/|:80/sql/|:80/administrator|:80/program/|:80/dbadmin|:80/php-my-admin/|:80/phpmanager/|GET /manager/html HTTP/1.1'| grep 'HTTP/1.1" 404 '| awk '{print $1}'| sort| uniq -c| sort -rn| awk '$1>=30{print $2}')
do
	grep -q $bad_ip $whitelist
	if [[ $? -ne 0 ]];then
		sed -i "/allow all;/i\ \ \ \ \ \ \ \ deny $bad_ip;" $whitelist
	fi
done
# 檢測配置文件并加載
nginx -t > /dev/null 2>&1
if [[ $? -eq 0 ]];then
	echo "$(date '+%F %T') [info] load nginx configure file and reload nginx" >> /usr/local/nginx/add_denyip.log
	nginx -s reload
else
	echo "$(date '+%F %T') [error] load nginx configure file failed" >> /usr/local/nginx/add_denyip.log
fi

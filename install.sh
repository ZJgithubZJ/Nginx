#!/bin/bash
#此脚本用于编译nginx-1.12，把集成包放在/usr/local下
yum -y install gcc pcre-devel openssl-devel
tar -zxvf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-file-aio --with-http_realip_module --conf-path=/usr/local/nginx/conf/nginx.conf --sbin-path=/usr/local/nginx/sbin/nginx --error-log-path=/usr/local/nginx/logs/nginx_err.log --pid-path=/usr/local/nginx/nginx.pid
echo 'Configure done!'
sleep 2
make
echo 'Make done!'
sleep 2
make install
echo 'Install done!'
mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf_bak
mv /usr/local/nginx.conf /usr/local/nginx/conf/
echo '======================================='
echo '/usr/local/nginx/sbin/nginx -t'
echo 'You can configure your nginx now!'
echo '======================================='

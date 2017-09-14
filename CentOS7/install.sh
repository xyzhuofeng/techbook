#!/bin/bash
# Install Nginx
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install nginx -y
systemctl start nginx
systemctl enable nginx

# Install MySQL
yum install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb

# Install PHP
rpm -Uvh http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y php71w php71w-bcmath php71w-cli php71w-common php71w-fpm php71w-gd php71w-mbstring php71w-mysqlnd php71w-opcache php71w-pdo php71w-pecl-redis php71w-process php71w-xml
systemctl start php-fpm
systemctl enable php-fpm

# Install Git
yum install git -y

systemctl restart nginx
exit 0
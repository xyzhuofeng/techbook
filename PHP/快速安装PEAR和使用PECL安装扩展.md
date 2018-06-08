# 快速安装PEAR和使用PECL安装扩展

by HyperQing

[TOC]

官网下载PEAR非常慢，本文档同一目录下提供了gp-pear.phar脚本
```
php go-pear.phar

pecl install mongodb

pecl install xdebug
```
如果因权限问题无法安装，前面加sudo

网速慢的，可以用手动下载到本地再通过pecl安装，例如
```
pecl install xdebug-2.6.0.tgz
pecl install mongodb-1.4.4.tgz
```


https://pecl.php.net/get/mongodb-1.4.4.tgz

https://pecl.php.net/get/xdebug-2.6.0.tgz

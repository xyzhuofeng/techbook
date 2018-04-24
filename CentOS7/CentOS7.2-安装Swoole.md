# CentOS 7.2 安装 Swoole

by HyperQing 2017-07-03

1. 安装php-devel，在我的环境已经有PHP71w等扩展。
```
yum install -y php71w-devel
```
其他环境下可能是
```
yum install -y php-devel
```

2. 通过pecl安装swoole
```
pecl install swoole
```

3. /etc/php.ini加入
```
extension=swolle.so
```

4. 检查安装情况
```
php -m
```
或
```
phpinfo()
```

5. 安装代码提示
```
composer require "eaglewu/swoole-ide-helper:dev-master" --prefer-dist
```
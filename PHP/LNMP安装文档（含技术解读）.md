# LNMP安装文档（含技术解读）

by HyperQing 2018-05-16

在腾讯云 CentOS 7.4 x64检验文档通过。（2018-05-16）

[TOC]

## 概要

**LNMP，即 Linux + Nginx + MySQL + PHP**。这是PHP服务器的经典搭配。

通过命令行进行安装，本次安装的软件版本说明：

- Nginx 1.13.x
- MySQL 8.0 和 5.7
- PHP 7.2.x

**更多资料**

关于LNMP和LEMP：https://lemp.io/

**注意**

- Nginx 默认使用80端口，请确保你的80端口无被其他软件占用（例如已经安装有Apache Server）。

如果是云服务器，请留意这些内容：

- 在“控制台->云服务器->安全组”中，检查你的服务器是否开放了80、22等常用端口。
- 建议你使用密钥（SSH2）登录你的服务器，密码已经不适用于生产环境了，尤其是开放22端口的情况，每时每刻都被爆破攻击。

这篇文章里，将描述如何在购买云服务器后安装 LNMP 环境。即，购买服务器后，且确保能够使用SSH连接工具（如Xshell，PuTTY）连接到服务器，就可以开始下面的步骤。

## 第一步: Nginx

首先安装 Nginx ，确保服务器是可以被访问的。

下面展示的是通过软件包管理器来安装的过程。不包含二进制文件或手动编译过程。

### 设置软件源

大多数发行版本都可以通过 YUM 或 APT 直接安装 Nginx 。如果没有 Nginx 或需要使用 Nginx 的最新稳定版，请按文档设置软件源。

官方文档已经列出安装方法，请按文档根据你的操作系统，设置 Nginx 的软件源。

>官方安装文档：http://nginx.org/en/linux_packages.html

对于 CentOS 系统，文档所示的添加软件源方法较麻烦。这里给出一个语句，快速添加文档要求的软件源。
```
echo -e "[nginx]\n"\
"name=nginx repo\n"\
"baseurl=http://nginx.org/packages/mainline/centos/7/\$basearch/\n"\
"gpgcheck=0\n"\
"enabled=1" > /etc/yum.repos.d/nginx.repo
```

### 执行安装

**Debian/Ubuntu**

见文档。
>http://nginx.org/en/linux_packages.html

**CentOS**
```
yum install nginx -y
```

### 启动 Nginx

安装完成后，Nginx 是不会自动启动的。需要手动启动 Nginx 服务，且将其设为开机自启。

**CentOS**
```
systemctl start nginx
systemctl enable nginx
```

### 测试 Nginx

nginx 的默认文档要目录是 `/usr/share/nginx/html`。

默认的 `index.html` 文件一定已经在这目录下了。

现在测试一下是否可以访问到这个测试 web 页，通过主机的ip地址或已绑定的域名进行访问。

**注意**
如果无法访问，请检查下列内容：

- 是否遗漏执行`systemctl start nginx`。
- 腾讯云或阿里云的控制中心->安全组是否正确设置，例如：开放80端口。

## 第二步: MySQL

本次安装 MySQL Community Server 进行演示。这里给出YUM和APT两种常用仓库的安装方式。

### YUM仓库

如果你使用的是YUM仓库进行安装，请阅读以下文章了解详细内容。下文提供的是操作摘要，由于官方文档不定期更新，不能保证下面摘要始终都是最新的。

>MySQL YUM仓库：http://dev.mysql.com/downloads/repo/yum/

>MySQL YUM仓库安装方法：https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/

添加最新 MySQL 源。
```
rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
```
- 查看所有 MySQL 软件版本，默认8.0的版本会写着“enable”。
- 如果你需要5.7版本，则禁用8.0版本的。
- 启用5.7版本。
- 操作完毕后，查看版本启用情况。
- 安装 MySQL 。
- 启动 MySQL 。
- 设置开机启动 MySQL。
```
yum repolist all | grep mysql
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community
yum repolist enabled | grep mysql
yum install mysql-community-server
systemctl start mysqld.service
systemctl enable mysqld.service
```
- 查看自动创建的临时密码。
```
grep 'temporary password' /var/log/mysqld.log
```
- 登录数据库。
- 修改密码。
```
mysql -uroot -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

### APT仓库

**注：以下内容未经经验，纯属整理参考，待日后验证或请热心人士帮忙验证。**

如果你使用的是APT仓库进行安装，请阅读以下文章了解详细内容。下文提供的是操作摘要，由于官方文档不定期更新，不能保证下面摘要始终都是最新的。

>MySQL APT仓库：https://dev.mysql.com/downloads/repo/apt/

>MySQL YUM仓库安装方法：https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/

添加最新 MySQL 源。
```
dpkg -i https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
```
- 选择版本。
- 更新源。
- 安装 MySQL 。
- 安装后会自动启动，查看运行状态即可。
```
dpkg-reconfigure mysql-apt-config
apt-get update
apt-get install mysql-server
service mysql status
```
- 启动/重启 MySQL。
- 停止 MySQL 。
```
service mysql start
service mysql stop
```
- 执行安全安装程序，在这个过程中可以设置密码。
```
mysql_secure_installation 
```

# === 后面未更，仅供参考 ===
## 第三步: PHP

终于到 PHP 了。这里将安装 PHP 7.1，这是编写文档时最新的版本。

### 安装yum源

CentOS 7 yum自带的源是PHP5.4版本，我们的目标是最新的PHP 7.1。这需要安装两个源：EPEL7和webtatic。

国内可能无法访问 https://dl.fedoraproject.org ，故下面这个源安装语句可能会执行失败。
```
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```
这里给出代替的语句，阿里镜像站的。注：若使用阿里云服务器，将源的域名从 mirrors.aliyun.com 改为 mirrors.aliyuncs.com ，不占用公网流量。
```
rpm -Uvh http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
```
清华大学镜像站的
```
rpm -Uvh https://mirrors.tuna.tsinghua.edu.cn/epel/epel-release-latest-7.noarch.rpm
```
然后安装另外一个源：webtatic（官网：https://webtatic.com/ 这里可以找到最新可用的PHP的源）
```
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```
以上提到的各种安装源语句，如果提示失败，请重试几次，成功会有进度条和100%字样(##############[100%])。
如果该yum源不可用，请使用其他源。


### 查看可安装的PHP版本和扩展

这个命令会列出可安装的程序或扩展，会显示程序版本信息。
```
yum list php*
```
这个命令会列出可安装的程序或扩展，及其简单说明。不显示程序版本信息。
```
yum search php71w
```
下面给出 PHP 7.1 可用的扩展的部分翻译和相关连接。

- php-bcmath：任意精度数学扩展库。 http://www.php.net/manual/zh/book.bc.php
- php-cli：PHP 的命令行模式。从命令行里测试 PHP 时非常有用。
- php-common：Common files for PHP。PHP的通用文件。
- php-dba：A database abstraction layer module for PHP applications。数据库抽象层。（用于Berkeley DB (伯克利数据库)）
- php-devel：php开发包。构建编译 PHP扩展时使用的文件。如果不需要编译就用不到。（**使用Swoole扩展库时需要**）
- php-embedded：PHP library for embedding in applications。内嵌到应用的PHP库。与php-fpm相对。常用的有5种形式，CLI/CGI（命令行）、Multiprocess（多进程）、Multithreaded（多线程）、FastCGI和Embedded（内嵌）。 http://blog.csdn.net/longxibendi/article/details/39587647
- php-enchant：Enchant spelling library，各种拼写库的抽象层。国际化与字符编码支持的其中一样。http://php.net/manual/zh/book.enchant.php
- php-fpm：FastCGI 进程管理器。http://php.net/manual/zh/book.fpm.php
- php-gd：PHP 的GD图像库处理支持。http://php.net/manual/zh/book.image.php
- php-imap：IMAP邮件协议相关扩展。http://php.net/manual/zh/book.imap.php
- php-intervase：Interbase/Firebird databases数据库扩展。
- php-intl：Internationalization Functions，国际化功能。http://php.net/manual/zh/book.intl.php
- php-ldap：Lightweight Directory Access Protocol，轻量级目录访问协议。
- php-mbstring：多字节字符串扩展库（例如：转码或计算UTF8字符串长度）http://php.net/manual/zh/book.mbstring.php
- php-mcrypt：加密支持扩展库。支持20多种加密算法和8种加密模式。在PHP7中淘汰不再使用，需要用openssl代替。 具体见：http://php.net/manual/zh/migration71.deprecated.php http://php.net/manual/zh/book.mcrypt.php
- php-mysql：MySQL扩展。从 PHP 5.5.0 起这个扩展已经被废弃，并且从 PHP 7.0.0. 开始被移除。作为替代，可以使用 mysqli 或者 PDO_MySQL 扩展代替。http://php.net/manual/zh/intro.mysql.php
- php-mysqlnd：Mysql Native驱动，最新的MySQL扩展，用 C 写成，5.3开始使用。 http://php.net/manual/zh/intro.mysqlnd.php
- php-odbc：用于连接ODBC数据库。例如：Microsoft Access数据库。http://php.net/manual/zh/intro.uodbc.php
- php-opcache：OPcache 通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能， 存储预编译字节码的好处就是 省去了每次加载和解析 PHP 脚本的开销。http://php.net/manual/zh/book.opcache.php
- php-pdo：PHP数据对象，提供了一个数据访问抽象层，不管使用哪种数据库，都可以用相同的函数（方法）来查询和获取数据。http://php.net/manual/zh/pdo.drivers.php
- php-pdo_dblib：用于连接Microsoft SQL Server数据库的扩展。
- php-pear.noarch：PHP Extension and Application Repository framework. PHP 扩展及应用仓库框架。 http://www.php.net/manual/zh/install.pecl.php
- php-pecl-apcu：来自 PECL 仓库的 ACPu 扩展，ACP User Cache。PHP 字节码和对象缓存器。在 PHP 5.2 版本后可使用OPcache代替。http://www.php.net/apcu https://bbs.aliyun.com/read/275941.html
- php-pecl-apcu-devel：ACPu 开发者文件。
- php-pecl-mongodb：PECL 包的 MongoDB 驱动。
- php-pecl-redis：PECL 包的 Redis 驱动。
- php-pecl-xdebug：PECL 包的 XDebug 扩展。强大的调试工具，在windows下结合phpstorm调试下过拔群，生产环境不推荐安装。
- php-pgsql：PostgreSQL 模块。
- php-phpdbg：PHP Debugger扩展。PHPDBG是一个PHP的SAPI模块，可以在不用修改代码和不影响性能的情况下控制PHP的运行环境。PHPDBG的目标是成为一个轻量级、强大、易用的PHP调试平台。可以在PHP5.4和之上版本中使用。在php5.6和之上版本将内部集成。生产环境不推荐安装。
- php-process：Modules for PHP script using system process interfaces。PHP脚本使用系统进程接口的模块。
- php-pspell：这个功能能够检查一个单词的拼写和提供一些建议。属于国际化与字符编码支持。http://php.net/manual/zh/book.pspell.php
- php-recode：包含一个GNU Recode libary的接口。这个库可以使文件在多编码字符集和编码编码之间转换。属于国际化与字符编码支持。此扩展在 Windows 平台上不可用。 http://php.net/manual/zh/intro.recode.php
- php-snmp：SNMP扩展提供一个非常简单且容易有效的工具集，通过SNMP协议（简单网络管理协议）来管理远程设备。
- php-soap：用于使用 SOAP 协议的模块。 http://php.net/manual/zh/book.soap.php
- php-tidy：标准PHP模块提供的tidy库支持。用来解析、格式化HTML，是一个出色的HTML解析引擎，它最初设计的目的是用来自动修正HTML中的错误和松散的标签。https://www.baidu.com/baidu?wd=tidy+库&tn=cnopera&ie=utf-8
- php-xml：XML 解析器。http://php.net/manual/zh/book.xml.php http://php.net/manual/zh/book.tidy.php
- php-xmlrpc：用于使用 XML-RPC 协议的模块。（此扩展是实验性 的。 此扩展的表象，包括其函数名称以及其他此扩展的相关文档都可能在未来的 PHP 发布版本中未通知就被修改。使用本扩展风险自担 。）http://php.net/manual/zh/intro.xmlrpc.php

### 执行安装
这里将安装 PHP 7.1 版本和笔者自己常用的扩展(满足普通Web项目，含Redis)，具体安装的扩展以实际需要为准。
```
yum install -y php71w php71w-bcmath php71w-cli php71w-common php71w-fpm php71w-gd php71w-mbstring php71w-mysqlnd php71w-opcache php71w-pdo php71w-pecl-redis php71w-process php71w-xml
```

### 启动 PHP-FPM

您需要启动 PHP-FPM ，然后把它放到自动启动服务列表。
```
systemctl start php-fpm
systemctl enable php-fpm
```

----
## 第四步: 配置 Nginx 和 PHP

Nginx 默认提供静态网站服务。要解析 PHP 脚本还需要进行一些设置。

### 配置 Nginx

接下来，让我们配置 Nginx 虚拟主机，使得 nginx 可以通过 PHP-FPM 来处理 PHP 的任务。用文本编辑器打开 /etc/nginx/conf.d/www.conf(该文件是不存在的，打开时将自动创建) ，然后按如下所示修改。
（建议使用WinSCP等FTP工具来修改文件，图形界面操作更方便）
```
vim /etc/nginx/conf.d/www.conf
```
www.conf文件内容：
```
server {
    listen       80;
    #你的域名或IP地址，多个用空格隔开
    server_name hyperqing.com www.hyperqing.com;
    #网站根目录
    #设置后下方fastcgi_param才能用$document_root表示
    root   /home/www;
    #开头添加index.php，默认页，如果只输入域名，则自动打开这个页面
    index  index.php index.html index.htm;
    #charset koi8-r;
    #access_log  /home/wwwlog/host.access.log  main;

    #404页面
    #error_page  404              /404.html;
    location = /404.html {
        #root   /usr/share/nginx/html;
    }

    #50x页面
    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
 
    #反向代理设置
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #下面这段location要开头的#取消注释
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include        fastcgi_params;
        #原/script$fastcgi_script_name
        # /script应换成网站目录绝对路径或$document_root
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    }

    #防盗链
    location ~ .*\.(wma|wmv|asf|mp3|mmf|zip|rar|jpg|gif|png|jpeg|swf|flv)$ {
        valid_referers none blocked *.hyperqing.com hyperqing.com;
        if ($invalid_referer)
        {
           #rewrite ^/ http://www.hyperqing.com/error.html;
           return 403;
        }
    }

    #下面这段是禁止访问.htaccess文件，如果你的项目中包含.htaccess文件，
    #部署在这个Nginx主机上，应该禁止访问该文件。
    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    location ~ /\.ht {
        deny  all;
    }
}
```
nginx 的默认工作线程数（在 /etc/nginx/nginx.conf 文件中指定的）是 1，让我们也来调整一下这个数字。通常来说我们创建的工作线程数应该和 CPU 核数相同。要查看您的 CPU 的核数，请运行下面这命令：
```
grep processor /proc/cpuinfo | wc -l
```
如果您的 CPU 是 4 核的，就如下所示修改 /etc/nginx/nginx.conf 文件。
```
vim /etc/nginx/nginx.conf 

worker_processes 4;
```
### 配置 PHP

接下来，修改 PHP 的配置文件 /etc/php.ini 。如果已经被注释掉，则去除属性前面的`;`分号。
```
cgi.fix_pathinfo=0
date.timezone = PRC
```
第一行，为了安全起见，我们希望的是 PHP 解释器只是处理指定文件路径的文件任务，而不是预测搜索一些并不存在的文件任务。上面的第一行起的就是这个作用。具体见另外一篇文档。如果你使用ThinkPHP、Laravel之类的框架，请将值设置为1或保持注释即可（默认值为1）。

第二行，定义的是 PHP 中日期/时间相关函数使用相关的默认时区。我们使用 PRC 或 Shanghai （中国/上海）即可。

### 测试 PHP

最后，测试一下 Nginx 是否能处理 PHP 页面。在测试之前，请确保重启 Nginx 和 PHP-FPM。
```
systemctl restart nginx
systemctl restart php-fpm
```
创建一个叫名叫 index.php 的文件，然后写入如下内容，并放入 /home/www 目录。
```php
<?php
phpinfo();
```
打开浏览器，输入 http://你的IP地址/index.php 。如果已经设置了域名解析，并在上面的 www.conf 的server_name 中填入你的域名，则可以通过域名访问。如果正常的话，就应该能看见php的软件信息页面。

## 其他配置

### 配置vim
腾讯云自带vim，阿里云7.2需要手动安装，如果不小心卸载或其他问题，请重新安装。
```
yum install vim -y
```
为了使之彩色显示代码，同时还支持行号标记和鼠标定位，需要编辑 vim 配置文件：
```
vim /etc/vimrc
```
从键盘输入 i 进入编辑模式，按 PgDn 到文本最后，在末尾分两行输入：
```
set nu
set mouse=a
```
从键盘输入 Ctrl+c或Esc，然后输入 :wq 保存、退出。

###更新 HOSTS 配置文件 /ETC/HOSTS

这个文件的作用跟 Windows 中的 HOSTS 类似，可以给本地系统直接解析域名。设置后，服务器访问自己本身的网站时就不需要经过DNS解析域名。

使用vim编辑文件
```
vim /etc/hosts
```
从键盘输入 i 进入编辑模式，按 PgDn 到文本最后，在末尾输入：后面是你的域名
```
127.0.0.1 your-domain.com
```
从键盘输入 Ctrl+c或Esc，然后输入 :wq 保存、退出。

### 修改主机名
```
hostname hyperqing.com
```
查看当前主机名
```
hostname
```

### CentOS 7 系统和软件升级
```
yum update -y
```

### 关于时区设置
阿里云和腾讯云中已设置好时区，输入命令，检查即可。
```
timedatectl
```

### 快照或备份
别忘了在阿里云或腾讯云控制台中备份镜像。

## 作者注

本文的上一个版本编辑于2017-01-09，距今（2018-05-16）已经过去一年半。随着作者的能力和经验提升，本文的行文措辞风格和呈现的内容发生较大变化，某些方面的描述可能已经不再具体，例如直接给出可用的命令等。教是为了不教，充分理解其原理和背景，受益会更大。
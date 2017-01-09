# CentOS 7.2 LENP环境配置文档

by HyperQing 整理和实践检验 2017-01-09

[TOC]

已适配阿里云主机 CentOS 7 x64，腾讯云 CentOS 7.2 x64。

>**LEMP 组合包**是一款日益流行的网站服务组合软件包，在许多生产环境中的核心网站服务上起着强有力的作用。正如其名称所暗示的， LEMP 包是由 Linux、nginx、MariaDB/MySQL 和 PHP 组成的。在传统的 LAMP 包中使用的 Apache HTTP 协议服务器性能低下而且难于大规模集群，相比来说 nginx 的高性能及轻量级等特性，正是其的替代方案。 MariaDB 是一款社区支持驱动的 MySQL 数据库的分支，其功能更多性能更佳。PHP，服务端编程语言，具体是由 PHP FastCGI 的增强版 PHP-FPM 组件来处理，生成网页动态内容。
>
>（LCTT 译注：为何采用 LEMP 而不是 LNMP 的缩写？据 https://lemp.io/ 的解释：Nginx 的发音是 Engine-X，重要的发音而不是首字母，而且 LEMP 实际上是可读的，而 LNMP 看起来只是字母表。）


这篇文章里，我们示范如何在 CentOS 操作平台上安装 LEMP 包。我们安装的目标是 CentOS 7.2。

------

## 第一步: Nginx

让我们在 CentOS 上安装 Nginx 作为第一步，然后对它作些基本的配置，比如使其能引导时启动和对防火墙做个性化设置。
### 安装 Nginx

yum中已经有Nginx软件，安装即可。
```
yum install nginx -y
```

### 启动 Nginx

安装完成后，nginx 是不会自动启动的。现在让我们来启动它吧，还要做些配置让其可以随着操作系统启动而启动。我们也需要在防火墙里打开 TCP/80 端口，以使得可以远程访问 nginx 的 web 服务。所有这些操作、设置都只需要输入如下命令就可实现。

```
systemctl start nginx
systemctl enable nginx
```
注：控制腾讯云、阿里云主机请省略以下两句，他们的控制中心均自带安全组用于配置端口。
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
```
### 测试 Nginx

nginx 的默认文档要目录是 `/usr/share/nginx/html`。默认的 `index.html` 文件一定已经在这目录下了。让我们检测下是否可以访问到这个测试 web 页，通过主机的ip地址或已绑定的域名进行访问。

如果您能看到Nginx的测试页面，说明 nginx 已经正常启动。内容大概是：

>Welcome to nginx on Fedora!
>This page is used to test the proper operation of the nginx HTTP server after it has been installed. If you can read this page, it means that the web server installed at this site is working properly.

>Website Administrator
>This is the default index.html page that is distributed with nginx on Fedora. It is located in /usr/share/nginx/html.

>You should now put your content in a location of your choice and edit the root configuration directive in the nginx configuration file /etc/nginx/nginx.conf.

**至于为什么会写着“Welcome to nginx on Fedora!”，因为阿里云、腾讯云的yum源是epel，epel是由Fedora维护的，所以你懂的，这并不影响使用。（手动修改yum源为Nginx官方源就没这个问题了。）**

------

### 第二步: MariaDB

下一步就是安装 LEMP 包的数据库组件。CentOS/RHEL 6 或早期的版本中提供的是 MySQL 的服务器/客户端安装包，但 CentOS/RHEL 7 已使用了 MariaDB 替代了默认的 MySQL。作为 MySQL 的替代品，MariaDB 保证了与 MySQL 的 API 和命令行用法方面最大的兼容性。下面是关于怎么在 CentOS 上安装和配置 MariaDB的操作示例。

安装 MariaDB 服务/客户端包以及启动 MariaDB 服务。
```
yum install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
```

在成功启动 MariaDB/MySQL 服务后，执行在 MariaDB/MySQL 服务包中的脚本。这一次的运行会为为数据库服务器进行一些安全强化措施，如设置 root 密码、删除匿名用户、锁定远程访问。
```
执行命令：
mysql_secure_installation

部分提示语翻译：
Enter current password for root (enter for none): ----》默认为空密码直接回车
Set root password? [Y/n] y                        ----》是否设置root密码（推荐：是）
New password:                                     ----》输入新密码
Re-enter new password:                            ----》再次确认新密码
Remove anonymous users? [Y/n] y                   ----》是否禁止匿名访问（推荐：是）
Disallow root login remotely? [Y/n] y             ----》不允许root远程访问（推荐：是）
Remove test database and access to it? [Y/n] y    ----》删除测试数据库test（推荐：是）
Reload privilege tables now? [Y/n] y              ----》重新加载授权信息（推荐：是）
```
还有设置UTF8编码，安装phpmyadmin数据库管理软件，见其他文档。

------

## 第三步: PHP

PHP 是 LEMP 包中一个重要的组件，它负责把存储在 MariaDB/MySQL 服务器的数据取出生成动态内容。为了 LEMP 需要，您至少需要安装上 PHP-FPM 和 PHP-MySQL 两个模块。PHP-FPM（FastCGI 进程管理器）实现的是 Nginx 服务器和生成动态内容的 PHP 应用程序的访问接口。PHP-MySQL 模块使 PHP 程序能访问 MariaDB/MySQL 数据库。

这里将安装 PHP 7.1，这是编写文档时最新的版本。

**安装yum源**

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
然后安装另外一个源：webtatic（官网：https://webtatic.com/ 这里可以找到最新可用的源，这是一个专门提供最新版LAMP环境的源）
```
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```
以上提到的各种安装源语句，如果提示失败，请重试几次，成功会有进度条和100%字样(##############[100%])。
如果该yum源不可用，请使用其他源。


**查看可安装的PHP版本**
```
yum list php*
```
确认存在php56w后安装
```
yum install -y php56w php56w-bcmath php56w-cli php56w-common php56w-fpm php56w-gd php56w-mbstring php56w-mcrypt php56w-mysqlnd php56w-opcache php56w-pdo php56w-pear php56w-pecl-apcu php56w-pecl-xdebug php56w-process php56w-xml
```
如果需要安装PHP7，请使用下面这段
```
yum install -y php70w php70w-bcmath php70w-cli php70w-common php70w-fpm php70w-gd php70w-mbstring php70w-mcrypt php70w-mysqlnd php70w-opcache php70w-pdo php70w-process php70w-xml
```

在 CentOS 7 中，在安装 PHP 包的同时会把 Apache web 服务器（即 httpd）当做它的依赖包一起安装。**这会Nginx 服务器起冲突。**这个问题会在下一节来讨论。

取决于您的使用情况，可以使用 yum 命令来定制您的 PHP 引擎，也许会想安装下面的任意一个扩展 PHP 模块包。

- php-bcmath：任意精度数学 http://www.php.net/manual/zh/book.bc.php
- php-cli：PHP 的命令行模式。从命令行里测试 PHP 时非常有用。
- php-common：
- php-dba：数据库抽象层。（用于Berkeley DB (伯克利数据库)）
- php-devel：php开发包。一般手动编译php扩展的时候用，如果不需要编译就用不到。
- php-embedded：Embedded（内嵌）实现。与php-fpm相对。常用的有5种形式，CLI/CGI（命令行）、Multiprocess（多进程）、Multithreaded（多线程）、FastCGI和Embedded（内嵌）。 http://blog.csdn.net/longxibendi/article/details/39587647
- php-enchant：Enchant spelling library，各种拼写库的抽象层。国际化与字符编码支持的其中一样。http://php.net/manual/zh/book.enchant.php
- php-fpm：FastCGI 进程管理器。http://php.net/manual/zh/book.fpm.php
- php-gd：PHP 的图像处理支持。http://php.net/manual/zh/book.image.php
- php-imap：邮件相关扩展。http://php.net/manual/zh/book.imap.php
- php-intervase：
- php-intl：Internationalization Functions，国际化功能。http://php.net/manual/zh/book.intl.php
- php-ldap：Lightweight Directory Access Protocol，轻量级目录权限协议。
- php-mbstring：UTF8多字节字符串扩展库（例如：转码或计算UTF8字符串长度）http://php.net/manual/zh/book.mbstring.php
- php-mcrypt：加密支持扩展库，支持20多种加密算法和8种加密模式 ，例如 DES、Blowfish、CBC、 CFB、ECB ciphers 、rc2等。http://php.net/manual/zh/book.mcrypt.php
- php-mysql：淘汰的mysql扩展。从 PHP 5.5.0 起这个扩展已经被废弃，并且从 PHP 7.0.0. 开始被移除。作为替代，可以使用 mysqli 或者 PDO_MySQL 扩展代替。http://php.net/manual/zh/intro.mysql.php
- php-mysqlnd：Mysql Native驱动，用C写的PHP扩展，5.3开始使用。 http://php.net/manual/zh/intro.mysqlnd.php
- php-odbc：用于连接Windows的数据源的数据库抽象层。例如：Microsoft Access数据库。http://php.net/manual/zh/intro.uodbc.php
- php-opcache：OPcache 通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能， 存储预编译字节码的好处就是 省去了每次加载和解析 PHP 脚本的开销。http://php.net/manual/zh/book.opcache.php
- php-pdo：PHP数据对象，提供了一个 数据访问 抽象层，不管使用哪种数据库，都可以用相同的函数（方法）来查询和获取数据。http://php.net/manual/zh/pdo.drivers.php
- php-pdo_dblib：用于连接Microsoft SQL Server数据库的扩展。
- php-pear.noarch：PECL 是通过 PEAR 打包系统做出来的 PHP 扩展库仓库。http://www.php.net/manual/zh/install.pecl.php
- php-pecl-apcu：来自 PECL 仓库的 ACPu 扩展，PHP 字节码和对象缓存器。在 PHP 5.2 版本后可使用OPcache代替。http://www.php.net/apcu https://bbs.aliyun.com/read/275941.html
- php-pecl-apcu-devel：上述ACPu的开发包，用于编译。
- php-pecl-mongodb：来自 PECL 仓库的 MongoDB 扩展。
- php-pecl-redis：来自 PECL 仓库的 Redis 扩展。
- php-pecl-xdebug：来自 PECL 仓库的 XDebug 扩展。强大的调试工具，在windows下结合phpstorm调试下过拔群，生产环境不推荐安装。
- php-pgsql：PostgreSQL 扩展。
- php-phpdbg：PHP Debugger扩展。PHPDBG是一个PHP的SAPI模块，可以在不用修改代码和不影响性能的情况下控制PHP的运行环境。PHPDBG的目标是成为一个轻量级、强大、易用的PHP调试平台。可以在PHP5.4和之上版本中使用。在php5.6和之上版本将内部集成。生产环境不推荐安装。
- php-process：
- php-pspell：这个功能能够检查一个单词的拼写和提供一些建议。属于国际化与字符编码支持。http://php.net/manual/zh/book.pspell.php
- php-recode：包含一个GNU Recode libary的接口。这个库可以使文件在多编码字符集和编码编码之间转换。属于国际化与字符编码支持。此扩展在 Windows 平台上不可用。 http://php.net/manual/zh/intro.recode.php
- php-snmp：SNMP扩展提供一个非常简单且容易有效的工具集，通过SNMP协议（简单网络管理协议）来管理远程设备。
- php-soap：SOAP，Web 服务。 http://php.net/manual/zh/book.soap.php
- php-tidy：用于清理HTML代码的，生成干净的符合W3C标准的HTML代码，支持HTML,XHTML,XML。纠错和过滤DOM文档。http://www.jb51.net/article/9350.htm 
- php-xml：XML 解析器。http://php.net/manual/zh/book.xml.php http://php.net/manual/zh/book.tidy.php
- php-xmlrpc：XML-RPC，Web 服务。（此扩展是实验性 的。 此扩展的表象，包括其函数名称以及其他此扩展的相关文档都可能在未来的 PHP 发布版本中未通知就被修改。使用本扩展风险自担 。）http://php.net/manual/zh/intro.xmlrpc.php

安装时，要查看可用的 PHP 模块的完整列表的话，可以运行：
```
yum search php- 
```

#### 启动 PHP-FPM

您需要启动 PHP-FPM ，然后把它放到自动启动服务列表。
```
systemctl start php-fpm
systemctl enable php-fpm
```

----
### 第四步: 配置 LEMP 组合包
本教程的最后一步是调整 LEMP 组合包的配置。

#### 使 Httpd 不可用

首先，让我们把早先随 PHP 包安装的 httpd 服务给禁用掉。

在 CentOS 7 系统上:
```
systemctl disable httpd
```

#### 配置 Nginx

接下来，让我们配置 nginx 虚拟主机，使得 nginx 可以通过 PHP-FPM 来处理 PHP 的任务。用文本编辑器打开 /etc/nginx/conf.d/www.conf(该文件是不存在的，打开时将自动创建) ，然后按如下所示修改。
（建议使用WinSCP等FTP工具来修改文件，图形界面操作更方便）
```
vim /etc/nginx/conf.d/www.conf
```
www.conf文件内容：
```
server {
    listen       80;
    #你的域名
    server_name hyperqing.com www.hyperqing.com;
    #网站根目录
    #设置后下方fastcgi_param才能用$document_root表示
    root   /home/www;
    #开头添加index.php，默认页，如果只输入域名，则自动打开这个页面
    index  index.php index.html index.htm;
    #charset koi8-r;
    access_log  /home/wwwlog/host.access.log  main;

    location / {

    }
    #404页面
    #error_page  404              /404.html;

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
####配置 PHP

接下来，让我们对 PHP 的配置文件 /etc/php.ini 做自定义设置。找到以下属性进行更改。
如果已经被注释掉，则去除属性前面的`;`分号。
```
cgi.fix_pathinfo=0
date.timezone = "PRC"
```
为了安全起见，我们希望的是 PHP 解释器只是处理指定文件路径的文件任务，而不是预测搜索一些并不存在的文件任务。上面的第一行起的就是这个作用。

第二行定义的是 PHP 中日期/时间相关函数使用相关的默认时区。使用本指南，找出您所在的时区，并设置相应 date.timezone 的值。（LCTT 译注：原文用的时区是“America/New York”，根据国内情况，应该用 PRC或 Asia 下的中国城市。）


####测试 PHP

最后，让我们来测试下 nginx 是否能处理 PHP 页面。在测试之前，请确保重启 nginx 和 PHP-FPM。

在 CentOS 7 系统上:
```
systemctl restart nginx
systemctl restart php-fpm
```
在 CentOS 6 系统上:
```
service nginx restart
service php-fpm restart
```
创建一个叫名叫 test.php 的文件，然后写入如下内容，并放入 /usr/share/nginx/html 目录。
```php
<?php phpinfo(); ?>
```
打开浏览器，输入 http://nginx的IP地址/test.php 。如果正常的话，就应该能看见php的版本组件信息页面。

----

### 其他配置

### 配置vim
阿里云自带vim，如果不小心卸载或其他问题，请重新安装。
```
yum -y install vim
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

----

###更新 HOSTS 配置文件 /ETC/HOSTS
这个文件的作用跟 Windows 中的 HOSTS 类似，可以给本地系统直接解析域名，这里设置了之后，这个系统访问 cnzhx.net 就不需要访问域名解析服务器了。

输入
```
vim /etc/hosts
```
从键盘输入 i 进入编辑模式，按 PgDn 到文本最后，在末尾输入：
```
127.0.0.1 hyperqing.com
```
从键盘输入 Ctrl+c或Esc，然后输入 :wq 保存、退出。

修改主机名
```
hostname hyperqing.com

```

----

###CentOS7软件升级
```
yum -y update
```
----

###关于时区设置
阿里云中已设置好时区，输入
```
timedatectl
```
检查即可。

----

###最后
别忘了在阿里云控制台中备份镜像


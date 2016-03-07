##在CentOS服务器上安装配置LEMP的详细教程
已适配阿里云主机 CentOS 7 x64
>**LEMP 组合包**是一款日益流行的网站服务组合软件包，在许多生产环境中的核心网站服务上起着强有力的作用。正如其名称所暗示的， LEMP 包是由 Linux、nginx、MariaDB/MySQL 和 PHP 组成的。在传统的 LAMP 包中使用的 Apache HTTP 协议服务器性能低下而且难于大规模集群，相比来说 nginx 的高性能及轻量级等特性，正是其的替代方案。 MariaDB 是一款社区支持驱动的 MySQL 数据库的分支，其功能更多性能更佳。PHP，服务端编程语言，具体是由 PHP FastCGI 的增强版 PHP-FPM 组件来处理，生成网页动态内容。
>
>（LCTT 译注：为何采用 LEMP 而不是 LNMP 的缩写？据 https://lemp.io/ 的解释：Nginx 的发音是 Engine-X，重要的发音而不是首字母，而且 LEMP 实际上是可读的，而 LNMP 看起来只是字母表。）


这篇文章里，我们示范如何在 CentOS 操作平台上安装 LEMP 包。我们安装的目标是 CentOS 6 和 CentOS 7 两个操作平台，如有必要会指出它们的不同。

------

###第一步: Nginx

让我们在 CentOS 上安装 nginx 作为第一步，然后对它作些基本的配置，比如使其能引导时启动和对防火墙做个性化设置。
####安装 Nginx

让我们从它的官方的 RPM 源来安装一个预构建的稳定版本的 nginx 包。

在 CentOS 7 系统上:
```
rpm --import http://nginx.org/keys/nginx_signing.key
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install nginx -y
```
在腾讯云CentOS7中，如果提示安装失败，原因缺少依赖libunwind.tar.gz的话
请重新执行上述两句，确保出现进度条和100%(###########[100%])

在 CentOS 6 系统上:
```
rpm --import http://nginx.org/keys/nginx_signing.key
rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install nginx -y
```
注意在安装 nginx RPM 包之前，如果您没有导入 nginx 的官方 GPG 密钥的话，会出一如下所示的警告:
```
warning: /var/tmp/rpm-tmp.KttVHD: Header V4 RSA/SHA1 Signature, key ID 7bd9bf62: NOKEY
```
####启动 Nginx

安装完成后，nginx 是不会自动启动的。现在让我们来启动它吧，还要做些配置让其可以随着操作系统启动而启动。我们也需要在防火墙里打开 TCP/80 端口，以使得可以远程访问 nginx 的 web 服务。所有这些操作、设置都只需要输入如下命令就可实现。

在 CentOS 7 系统上:
```
systemctl start nginx
systemctl enable nginx
```
//腾讯云、阿里云主机请省略以下两句，他们的管理中心均自带安全组配置用户管理端口
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
```
在 CentOS 6 系统上:
```
service nginx start
chkconfig nginx on
iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
service iptables save
```
####测试 Nginx

nginx 的默认文档要目录是 /usr/share/nginx/html。默认的 index.html 文件一定已经在这目录下了。让我们检测下是否可以访问到这个测试 web 页，通过主机的ip地址或已绑定的域名进行访问。

如果您能看到Nginx的测试页面，说明 nginx 已经正常启动。

------

###第二步: MariaDB/MySQL

下一步就是安装 LEMP 包的数据库组件。CentOS/RHEL 6 或早期的版本中提供的是 MySQL 的服务器/客户端安装包，但 CentOS/RHEL 7 已使用了 MariaDB 替代了默认的 MySQL。作为 MySQL 的简单替代品，MariaDB 保证了与 MySQL 的 API 和命令行用法方面最大的兼容性。下面是关于怎么在 CentOS 上安装和配置 MaraDB/MySQL 的操作示例。

在 CentOS 7 系统上:

如下所示操作来安装 MariaDB 服务/客户端包以及启动 MariaDB 服务。
```
yum install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
```
在 CentOS 6 系统上:

如下示，安装 MySQL 服务/客户端包并且启动 MySQL 服务。
```
yum install mysql-server -y
service mysqld start
chkconfig mysqld on
```
在成功启动 MariaDB/MySQL 服务后，执行在 MariaDB/MySQL 服务包中的脚本。这一次的运行会为为数据库服务器进行一些安全强化措施，如设置（非空）的 root 密码、删除匿名用户、锁定远程访问。
```
执行命令：
mysql_secure_installation

部分提示语翻译：
Enter current password for root (enter for none): ----》默认为空密码直接回车
Set root password? [Y/n] y                        ----》设置root密码
New password:                                     ----》新密码
Re-enter new password:                            ----》再次确认新密码
Remove anonymous users? [Y/n] y                   ----》禁止匿名访问
Disallow root login remotely? [Y/n] y             ----》不允许root远程访问
Remove test database and access to it? [Y/n] y    ----》删除测试数据库test
Reload privilege tables now? [Y/n] y              ----》重新加载授权信息
```
这就是数据库的设置。现在进行下一步。

------
###第三步: PHP

PHP 是 LEMP 包中一个重要的组件，它负责把存储在 MariaDB/MySQL 服务器的数据取出生成动态内容。为了 LEMP 需要，您至少需要安装上 PHP-FPM 和 PHP-MySQL 两个模块。PHP-FPM（FastCGI 进程管理器）实现的是 nginx 服务器和生成动态内容的 PHP 应用程序的访问接口。PHP-MySQL 模块使 PHP 程序能访问 MariaDB/MySQL 数据库。

这里将安装php5.6.16，这是编写文档时最新的版本。

在 CentOS 7 系统上:
安装yum源（官网：https://webtatic.com/ 这里可以找到最新可用的源，这是一个专门提供最新版LAMP环境的源）
```
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```
如果提示失败，请重试几次，成功会有进度条和100%字样(##############[100%])
如果该yum源不可用，请使用其他源

查看安装版本
```
yum list php*
```
确认存在php56w后安装
```
yum install -y php56w php56w-bcmath php56w-cli php56w-dba php56w-common php56w-devel php56w-fpm php56w-gd php56w-mbstring php56w-mcrypt php56w-mysqlnd php56w-opcache php56w-pdo php56w-pear php56w-pecl-apcu php56w-pecl-xdebug php56w-process php56w-xml
```
PHP7 （参考:http://www.tuicool.com/articles/BvUv2aq）
```
yum install -y php70w php70w-bcmath php70w-cli php70w-common php70w-dba php70w-devel php70w-fpm php70w-gd php70w-mbstring php70w-mcrypt php70w-mysqlnd php70w-opcache php70w-pdo php70w-pear php70w-pecl-apcu php70w-process php70w-xml
```
在 CentOS 6 系统上:
首先，您需要从仓库中安装 REMI 库（参见本指南），并安装软件包。
```
yum --enablerepo=remi install php php-fpm php-mysql
```
在安装 PHP 时，得注意两个地方:

在 CentOS 6 系统中，安装 REMI仓库中最新的 php-mysql 模块时，MySQL 的服务端包和客户端包会被当做一部分依赖包而自动的更新。

在 CentOS 6 和 CentOS 7 中，在安装 PHP 包的同时会把 Apache web 服务器（即 httpd）当做它的依赖包一起安装。**这会跟 nginx web 服务器起冲突。**这个问题会在下一节来讨论。

取决于您的使用情况，可以使用 yum 命令来定制您的 PHP 引擎，也许会想安装下面的任意一个扩展 PHP 模块包。
    php-mysqlnd: mysql扩展，5.4以上版本默认以mysqlnd替代
    php-cli: PHP 的命令行界面。从命令行里测试 PHP 时非常有用。
    php-gd: PHP 的图像处理支持。
    php-bcmath: PHP 的数学支持。
    php-mcrypt: PHP 的加密算法支持 (例如 DES、Blowfish、CBC、 CFB、ECB ciphers 等)。
    php-xml: PHP 的 XML 解析和处理支持。
    php-dba: PHP 的数据抽象层支持。
    php-pecl-apc: PHP 加速器/缓存支持。
安装时，要查看可用的 PHP 模块的完整列表的话，可以运行：
```
//CentOS 7中
yum search php- 
// CentOS 6中
yum --enablerepo=remi search php-
```
###启动 PHP-FPM

您需要启动 PHP-FPM ，然后把它放到自动启动服务列表。

在 CentOS 7 系统上:

```
systemctl start php-fpm
systemctl enable php-fpm
```
在 CentOS 6 系统上:
```
chkconfig php-fpm on
service php-fpm start
```

----
###第四步: 配置 LEMP 组合包
本教程的最后一步是调整 LEMP 组合包的配置。
####使 Httpd 不可用

首先，让我们把早先随 PHP 包安装的 httpd 服务给禁用掉。

在 CentOS 7 系统上:
```
systemctl disable httpd
```
在 CentOS 6 系统上:
```
chkconfig httpd off
```
####配置 Nginx

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
如果已经被注释掉，则去除属性前面的`#`号。
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

###配置vim
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


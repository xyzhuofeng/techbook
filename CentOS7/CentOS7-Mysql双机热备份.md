#CentOS7-Mysql双机热备份

by HyperQing 整理

笔者环境：
主服务器：阿里云，CentOS7 x64，MariaDB 5.5
从服务器：腾讯云，CentOS7 x64，MariaDB 5.5

##1 同步初期数据库

将主服务器需要同步的数据库内容进行备份一份，上传到从服务器上，保证始初时两服务器中数据库内容一致。

----

##2 创建同步用户
进入mysql操作界面，在主服务器上为从服务器建立一个连接帐户，该帐户必须授予`REPLICATION SLAVE`权限。因为从mysql版本3.2以后就可以通过`REPLICATION`对其进行双机热备的功能操作。
下面语句中，`replicate`即为从服务器登录到主服务器的用户名。`备机ip`指定IP的从服务器可以通过前述用户名登录该主服务器。`identified by`后面则是密码，从服务器将使用`replicate`用户名和这里提供的密码进行登录。创建用户后刷新权限。
```
mysql> grant replication slave on *.* to 'replicate'@'备机ip' identified by '123456';
mysql> flush privileges;
```
创建好同步连接帐户后，我们可以通过在从服务器（Slave）上用replicate帐户对主服务器（Master）数据库进行访问下，看下是否能连接成功。
在从服务器（Slave）上输入如下指令：
```
mysql -h主机ip -ureplicate -p123456
```

----

##3 修改配置文件
如果上面的准备工作做好，那边我们就可以进行对mysql配置文件进行修改了。笔者的mysql配置文件目录在/etc/my.cnf.d。建议使用WinSCP等FTP工具修改文件。
```
服务器配置文件server.cnf
[mysqld]
server-id = 1  #该id应该是唯一的，例如主服务器为1，从服务器为2
log-bin=mysql-bin  #日志文件
binlog-do-db= test   #进行主从热备份的数据库名，这里应该替换成你的数据库 
binlog-ignore-db= mysql,performance_schema,information_schema
```
重启mysql服务（记得使用`quit`退出mysql控制台）
```
systemctl restart mariadb
```
##4 锁表并查看master信息
为了避免设置从服务器时，主服务器数据库发生变动，先对主服务器进行锁表。
在主服务器上操作，进入mysql控制台后，输入以下命令：
```
mysql>flush tables with read lock;
```
查看master信息
```
mysql>show master status\G;
*******************1.row*****************
   File:mysql-bin.000001
   Position:450
   Binlog_Do_DB:test
   Binlog_Ignore_DB:mysql,performance_schema,information_schema
```
获取类似上面的提示信息，这里的File值和Position将会在从服务器的配置中使用到，这里暂且记录下来。

##5 配置从服务器
因为这里面是以主－从方式实现mysql双机热备的，所以在从服务器就不用在建立同步帐户了。直接打开配置文件进行配置。笔者的mysql配置文件目录在/etc/my.cnf.d。建议使用WinSCP等FTP工具修改文件。
```
服务器配置文件server.cnf
[mysqld]
server-id = 1  #该id应该是唯一的，例如主服务器为1，从服务器为2
log-bin=mysql-bin  #日志文件
binlog-do-db= test   #进行主从热备份的数据库名，这里应该替换成你的数据库 
binlog-ignore-db= mysql,performance_schema,information_schema
```
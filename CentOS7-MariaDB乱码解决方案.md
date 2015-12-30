#CentOS7-MariaDB乱码解决方案

by HyperQing 整理

----

登录mysql，输入密码后按回车
即使你安装了mariadb，在这里也照样可以用mysql命令
```
mysql -uroot -p
Enter Password:
```
输入语句查询MariaDB编码设置
```
show variables like "%char%"; 
```
你将得到这样的信息
```
MariaDB [(none)]> show variables like "%char%"; 
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | latin1                     |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | latin1                     |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```
从该信息看出，数据库和数据库服务器都使用了latin1编码
该编码向下兼容ASCII码，十六进制表示范围从（0x00~0xFF）
ASCII码十六进制表示范围从（0x00~0x7F）

现在我们将这两项设置改为UTF-8编码
MariaDB配置文件在`/etc/my.cnf.d`
(建议使用WinSCP等FTP工具来修改，图形化界面方便操作，vim也可以)

客户端配置`client.cnf`
```
[client]
default-character-set=utf8
```

服务器配置`server.cnf`
```
[mysqld]
default-storage-engine=INNODB
character-set-server=utf8
collation-server=utf8_general_ci
```

linux命令行客户端配置`mysql-clients.cnf`
```
[mysql]
default-character-set=utf8
```
重启mariadb服务
```
systemctl restart mariadb
```
再次查询编码信息，结果如下所示
```
MariaDB [(none)]> show variables like "%char%"; 
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```
设置成功！
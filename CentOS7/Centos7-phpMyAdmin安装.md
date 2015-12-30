#Centos7-phpMyAdmin安装

by HyperQing 整理

**已适配阿里云CentOS7、Nginx 1.8.0环境。**

打开[phpMyAdmin官网](http://www.phpmyadmin.net/),进入下载页，选择合适的版本。
这里选择.tar.gz后缀的压缩包，方便在Linux环境下解压。

获取下载地址后，使用 curl 去下载它。
`curl -L`允许自动跳转  `-o` 目标文件名
```
cd ~
curl -L https://files.phpmyadmin.net/phpMyAdmin/4.5.3.1/phpMyAdmin-4.5.3.1-all-languages.tar.gz -o phpMyAdmin.tar.gz
```
使用tar工具解压上面下载的压缩包，解压后删除压缩包。`rm -f`为无论是否存在都强制删除文件，不进行提示。
```
tar -zxvf phpMyAdmin.tar.gz
rm -f phpMyAdmin.tar.gz
```


用`ls`命令查看一下当前目录下的东西，会出现解压之后的目录，目录的名称取决于你下载的 phpMyAdmin 的版本，我这里现在是 phpMyAdmin-4.5.3.1-all-languages 。
输出如下所示
```
[root@iZ2k4Zk4Zk4Z ~]# ls
phpMyAdmin-4.5.3.1-all-languages
```
##这里给出两种访问方式
###通过普通路径访问（如http://domain.com/phpmyadmin）
将该目录移动到Nginx服务器目录下，我的环境中是`/usr/share/nginx/html/`。
```
mv phpMyAdmin-4.5.3.1-all-languages /usr/share/nginx/html/phpmyadmin
```

此时你可以这样访问phpMyAdmin
http://domain.com/phpmyadmin

###通过二级域名访问（如http://phpmyadmin.domain.com）




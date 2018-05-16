# 安装phpMyAdmin

by HyperQing 整理 2018-05-16

1. 打开[phpMyAdmin官网](http://www.phpmyadmin.net/)。
2. 导航条点击击“Download”进入下载页。
3. 选择合适的版本，这里选择.tar.gz后缀的压缩包，方便在Linux环境下解压。

获取下载地址后，使用 curl 去下载它。
`curl -L`允许自动跳转  `-o` 目标文件名
```
cd ~
curl -L https://files.phpmyadmin.net/phpMyAdmin/4.8.0.1/phpMyAdmin-4.8.0.1-all-languages.tar.gz
```
使用tar工具解压上面下载的压缩包，解压后删除压缩包。`rm -f`为无论是否存在都强制删除文件，不进行提示。
```
tar -zxvf phpMyAdmin-4.8.0.1-all-languages.tar.gz
rm -f phpMyAdmin-4.8.0.1-all-languages.tar.gz
```


用`ls`命令查看一下当前目录下的东西，会出现解压之后的目录，目录的名称取决于你下载的 phpMyAdmin 的版本，我这里现在是 phpMyAdmin-4.6.0-all-languages 。
输出如下所示
```
[root@localhost ~]# ls
phpMyAdmin-4.8.0.1-all-languages
```
##这里给出两种访问方式
###通过普通路径访问（如http://domain.com/phpmyadmin）
将该目录移动到Nginx服务器目录下，我的环境中是`/usr/share/nginx/html/`。
```
mv phpMyAdmin-4.8.0.1-all-languages /usr/share/nginx/html/phpmyadmin
```

此时你可以这样访问phpMyAdmin
http://domain.com/phpmyadmin

###通过二级域名访问（如http://phpmyadmin.domain.com）

附：常用的Nginx配置

```
server {
    listen       80;
    server_name abc.domain.com;
    root   /home/phpmyadmin;
    index  index.php index.html index.htm;
    #charset koi8-r;
    access_log  /home/accesslog/mysqladmin.access.log  main;
    location / {
    }
    #error_page  404              /404.html;
    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        #root   /usr/share/nginx/html;
    }
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include        fastcgi_params;
        #script$fastcgi_script_name
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    location ~ /\.ht {
        deny  all;
    }
}
```

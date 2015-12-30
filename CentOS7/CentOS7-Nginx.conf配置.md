#Nginx.conf 配置说明

by Hyper庆 整理

本文讨论Nginx.conf 配置和结合ThinkPHP 3.2.3的PATHINFO特性，实现重写URL为"http://domain.com/Home/Index/index"这种类型。
>Nginx ("engine x") 是一个高性能的HTTP和 反向代理 服务器，也是一个 IMAP/POP3/SMTP 服务器。

文件位置：在笔者使用的CentOS7环境中，Nginx一系列配置文件被放置在/etc/nginx/目录下。

```
#定义Nginx运行的用户和用户组
user www www;
 
#nginx进程数，建议设置为等于CPU总核心数。
worker_processes 8;

#全局错误日志定义类型，[ debug | info | notice | warn | error | crit ]
error_log ar/loginx/error.log info;
 
#进程文件
pid ar/runinx.pid;
 
#一个nginx进程打开的最多文件描述符数目，理论值应该是最多打开文件数（系统的值ulimit -n）与nginx进程数相除，但是nginx分配请求并不均匀，所以建议与ulimit -n的值保持一致。
worker_rlimit_nofile 65535;

#工作模式与连接数上限
events
{
	#参考事件模型，use [ kqueue | rtsig | epoll | /dev/poll | select | poll ]; epoll模型是Linux 2.6以上版本内核中的高性能网络I/O模型，如果跑在FreeBSD上面，就用kqueue模型。
	use epoll;
	#单个进程最大连接数（最大连接数=连接数*进程数）
	#工作进程的最大连接数量，根据硬件调整，和前面工作进程配合起来用，尽量大，但是别把cpu跑到100%就行
	worker_connections 4096;
}

#设定http服务器
http
{
	include mime.types; #文件扩展名与文件类型映射表
	include /etc/nginx/proxy.conf;#反向代理配置，可以打开proxy.conf看看
	include /etc/nginx/fastcgi.conf;#fastcgi配置，可以打开fastcgi.conf看看
	
	default_type application/octet-stream; #默认文件类型
	
	#日志的格式
	log_format main ‘$remote_addr – $remote_user [$time_local] $status ‘
	‘”$request” $body_bytes_sent “$http_referer” ‘
	‘”$http_user_agent” “$http_x_forwarded_for”’;
	#访问日志
	access_log logs/access.log main;
	
	#charset utf-8; #默认编码
	server_names_hash_bucket_size 128; #服务器名字的hash表大小
	client_header_buffer_size 32k; #上传文件大小限制
	large_client_header_buffers 4 64k; #设定请求缓
	client_max_body_size 8m; #设定请求缓
	sendfile on; #开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。
	autoindex on; #开启目录列表访问，合适下载服务器，默认关闭。
	tcp_nopush on; #防止网络阻塞
	tcp_nodelay on; #防止网络阻塞
	keepalive_timeout 120; #长连接超时时间，单位是秒
 
	#FastCGI相关参数是为了改善网站的性能：减少资源占用，提高访问速度。下面参数看字面意思都能理解。
	fastcgi_connect_timeout 300;
	fastcgi_send_timeout 300;
	fastcgi_read_timeout 300;
	fastcgi_buffer_size 64k;
	fastcgi_buffers 4 64k;
	fastcgi_busy_buffers_size 128k;
	fastcgi_temp_file_write_size 128k;
 
	#gzip模块设置
	gzip on; #开启gzip压缩输出
	gzip_min_length 1k; #最小压缩文件大小
	gzip_buffers 4 16k; #压缩缓冲区
	gzip_http_version 1.0; #压缩版本（默认1.1，前端如果是squid2.5请使用1.0）
	gzip_comp_level 2; #压缩等级
	gzip_types text/plain application/x-javascript text/css application/xml;
	#压缩类型，默认就已经包含textml，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。
	gzip_vary on;
	#limit_zone crawler $binary_remote_addr 10m; #开启限制IP连接数的时候需要使用
 
	upstream blog.ha97.com {
		#upstream的负载均衡，weight是权重，可以根据机器配置定义权重。weigth参数表示权值，权值越高被分配到的几率越大。
		server 192.168.80.121:80 weight=3;
		server 192.168.80.122:80 weight=2;
	}
}

#虚拟主机的配置
server
{
	#监听端口
	listen 80;
	#域名可以有多个，用空格隔开
	server_name www.ha97.com ha97.com;
	index index.html index.htm index.php;
	root /data/www/ha97;
	location ~ .*.(php|php5)?$
	{
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi.conf;
	}
	#图片缓存时间设置
	location ~ .*.(gif|jpg|jpeg|png|bmp|swf)$
	{
		expires 10d;
	}
	#JS和CSS缓存时间设置
	location ~ .*.(js|css)?$
	{
		expires 1h;
	}
	#日志格式设定
	log_format access '$remote_addr - $remote_user [$time_local] "$request" '
	'$status $body_bytes_sent "$http_referer" '
	'"$http_user_agent" $http_x_forwarded_for';
	#定义本虚拟主机的访问日志
	access_log ar/loginx/ha97access.log access;
 
	#对 "/" 启用反向代理
	location / {
		proxy_pass http://127.0.0.1:88;
		proxy_redirect off;
		proxy_set_header X-Real-IP $remote_addr;
		#后端的Web服务器可以通过X-Forwarded-For获取用户真实IP
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		#以下是一些反向代理的配置，可选。
		proxy_set_header Host $host;
		client_max_body_size 10m; #允许客户端请求的最大单文件字节数
		client_body_buffer_size 128k; #缓冲区代理缓冲用户端请求的最大字节数，
		proxy_connect_timeout 90; #nginx跟后端服务器连接超时时间(代理连接超时)
		proxy_send_timeout 90; #后端服务器数据回传时间(代理发送超时)
		proxy_read_timeout 90; #连接成功后，后端服务器响应时间(代理接收超时)
		proxy_buffer_size 4k; #设置代理服务器（nginx）保存用户头信息的缓冲区大小
		proxy_buffers 4 32k; #proxy_buffers缓冲区，网页平均在32k以下的设置
		proxy_busy_buffers_size 64k; #高负荷下缓冲大小（proxy_buffers*2）
		proxy_temp_file_write_size 64k;
		#设定缓存文件夹大小，大于这个值，将从upstream服务器传
	}
 
	#设定查看Nginx状态的地址
	location /NginxStatus {
		stub_status on;
		access_log on;
		auth_basic "NginxStatus";
		auth_basic_user_file confpasswd;
		#htpasswd文件的内容可以用apache提供的htpasswd工具来产生。
	}
 
	#本地动静分离反向代理配置
	#所有jsp的页面均交由tomcat或resin处理
	location ~ .(jsp|jspx|do)?$ {
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_pass http://127.0.0.1:8080;
	}
	#所有静态文件由nginx直接读取不经过tomcat或resin
	location ~ .*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$
	{ 
		expires 15d; 
	}
	location ~ .*.(js|css)?$
	{ 
		expires 1h; 
	}
}
```

附上一个笔者环境下的默认配置：

```
user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```
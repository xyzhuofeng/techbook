#Nginx适配Thinkphp的PATH_INFO的URL模式
ThinkPHP支持通过PATHINFO和URL rewrite的方式来提供友好的URL，只需要在配置文件中设置 'URL_MODEL' => 2 即可。在Apache下只需要开启mod_rewrite模块就可以正常访问了，但是Nginx中默认是不支持PATHINFO的，所以我们需要修改nginx.conf文件。

这里先把project下的请求都转发到index.php来处理，亦即ThinkPHP的单一入口文件；然后把对php文件的请求交给fastcgi来处理，并且添加对PATH_INFO的支持。
重启Nginx以后，http://localhost/project/Index/insert, http://localhost/project/index.php/Index/delete 这样的URL都可以正确访问了。

还有一个地方需要注意的是，Nginx配置文件里 if 和后面的括号之间要有一个空格，不然会报nginx: [emerg] unknown directive "if"错误。
Nginx版本：1.8.0

PHP.ini配置中关于cgi.path_info的注释
```
; cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
; previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
; what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
; this to 1 will cause PHP CGI to fix its paths to conform to the spec.  A setting
; of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
; to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
; http://php.net/cgi.fix-pathinfo
```

```
server {
    listen       80;
    #你的域名
    server_name  shujuren.org www.shujuren.org;
    index index.php index.html index.htm index.shtml;   
    root /usr/share/nginx/html;
    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;
    
	location / {   
	 if (!-e $request_filename){   
	      #rewrite ^(.*)$ /index.php?s=/$1 last; #rewrite模式   
	      rewrite ^(.*)$ /index.php/$1 last; #pathinfo模式 任选其一   
	  }   
	}   
	
	location ~ \.php {
		fastcgi_pass    127.0.0.1:9000;
		fastcgi_split_path_info ^(.+\.php)(.*)$;
		fastcgi_param PATH_INFO $fastcgi_path_info;
		#早期包含这句，但后来的部署发现，php配置中cgi.path_info=0时
		#访问网站会出现Access denied.的错误
		#如php配置中注释所言，该变量要开启cgi.path_info=1才能用
		#fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include         fastcgi_params;
		fastcgi_connect_timeout 300;   
		fastcgi_send_timeout 300;
		fastcgi_read_timeout 300;
	}

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
 
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
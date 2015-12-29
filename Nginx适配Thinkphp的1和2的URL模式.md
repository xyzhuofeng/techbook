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
		fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;   
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
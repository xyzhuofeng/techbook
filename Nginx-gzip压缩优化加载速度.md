    #开启Gzip
    gzip  on;
    gzip_min_length 1k;
    gzip_buffers 4 16k;
    gzip_comp_level 3;
    gzip_types text/html text/css image/png image/jpeg application/javascript text/javascript image/gif;
    gzip_disable "MSIE [1-6].";
    gzip_vary off;
    
    http://www.php100.com/html/program/nginx/2013/0905/5526.html
    
    http://www.cnblogs.com/mitang/p/4477220.html
    
    http://www.webkaka.com/blog/archives/how-to-set-gzip-for-js-in-Nginx.html
    专业网站测速平台
    http://pagespeed.webkaka.com
    站长工具
    http://tool.chinaz.com/Gzips
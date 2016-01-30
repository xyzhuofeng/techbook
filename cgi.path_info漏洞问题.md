#cgi.path_info漏洞问题

by HyperQing 整理

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

比如, 有http://www.laruence.com/fake.jpg, 那么通过构造如下的URL, 就可以看到fake.jpg的二进制内容:
```
http://www.laruence.com/fake.jpg/foo.php
```
为什么会这样呢?
比如, 如下的nginx conf:
```
location ~ \.php($|/) {
     fastcgi_pass   127.0.0.1:9000;
     fastcgi_index  index.php;
 
     set $script    $uri;
     set $path_info "";
     if ($uri ~ "^(.+\.php)(/.*)") {
          set  $script     $1;
          set  $path_info  $2;
     }
 
     include       fastcgi_params;
     fastcgi_param SCRIPT_FILENAME   $document_root$script;
     fastcgi_param SCRIPT_NAME       $script;
     fastcgi_param PATH_INFO         $path_info;
}
```
通过正则匹配以后, SCRIPT_NAME会被设置为”fake.jpg/foo.php”, 继而构造成SCRIPT_FILENAME传递个PHP CGI, 但是PHP又为什么会接受这样的参数, 并且把a.jpg解析呢?

这就要说到PHP的cgi SAPI中的参数, fix_pathinfo了:
```
; cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
; previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
; what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
; this to 1 will cause PHP CGI to fix it's paths to conform to the spec.  A setting
; of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
; to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
cgi.fix_pathinfo=1
```
如果开启了这个选项, 那么就会触发在PHP中的如下逻辑:
```
/*
 * if the file doesn't exist, try to extract PATH_INFO out
 * of it by stat'ing back through the '/'
 * this fixes url's like /info.php/test
 */
if (script_path_translated &&
     (script_path_translated_len = strlen(script_path_translated)) > 0 &&
     (script_path_translated[script_path_translated_len-1] == '/' ||
....//以下省略.
```
到这里, PHP会认为SCRIPT_FILENAME是fake.jpg, 而foo.php是PATH_INFO, 然后PHP就把fake.jpg当作一个PHP文件来解释执行… So…

这个隐患的危害用小顿的话来说, 是巨大的.

对于一些论坛来说, 如果上传一个图片(实际上是恶意的PHP脚本), 继而构造这样的访问请求…

所以, 大家如果有用这种服务器搭配的, 请排查, 如果有隐患, 请关闭fix_pathinfo(默认是开启的).
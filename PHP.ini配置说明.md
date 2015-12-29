#php.ini常用配置说明.md

by Hyper庆整理

笔者的主机环境：CentOS7。
php.ini配置文件在/etc/php.ini

具体参阅官网
[http://php.net/manual/zh/ini.core.php](http://php.net/manual/zh/ini.core.php)
下列是常用的部分默认设置

文件上传开关
`file_uploads = On`

缓存目录
`upload_tmp_dir=`默认为空
单个上传文件最大体积
`upload_max_filesize = 2M`

单次上传文件数量
`max_file_uploads = 20`

POST表单大小
`post_max_size = 8M`

默认编码
`default_charset = "UTF-8"`
# 结合PHPStorm使用Xdebug调试

by HyperQing

## 准备

WAMP Server
PHPStorm

## 修改php.ini

打开php.ini文件后，查找Xdebug配置。在下面所示的地方进行修改。
```
[xdebug]
zend_extension ="E:/wamp64/bin/php/php7.0.4/zend_ext/php_xdebug-2.4.0-7.0-vc14-x86_64.dll"

xdebug.remote_enable = off
xdebug.profiler_enable = off
xdebug.profiler_enable_trigger = Off
xdebug.profiler_output_name = cachegrind.out.%t.%p
xdebug.profiler_output_dir ="E:/wamp64/tmp"
xdebug.show_local_vars=0
```
添加这两句，如果已经存在，修改其值即可。
```
xdebug.remote_enable = on // 启用Xdebug
xdebug.idekey = PHPSTORM // 指定IDE Key
```
保存并重启WAMP Server。

##

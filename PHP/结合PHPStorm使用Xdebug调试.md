# 结合PHPStorm使用Xdebug调试

by HyperQing

[TOC]
## 准备

- PHPStorm
- WAMP Server（或其他同类PHP服务器）
- Xdebug （装WAMP Server时自带）

## 修改php.ini

打开`php.ini`文件后，查找Xdebug配置。在下面所示的地方进行修改。
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
如果你的9000端口被占用，你还需要加多一句来修改默认端口。(你可以通过`phpinfo()`方法查看当前`Xdebug`配置的端口)
```
xdebug.remote_port = 9001
```
保存并重启WAMP Server。

## 修改PHPStorm的Xdebug端口（可选）
如果你在上面的操作中修改了端口，打开`File->Settings...`，搜索`xdebug`。修改Debug port即可。

## 添加运行/调试配置

打开`Run->Edit Configurations...`。
在左侧菜单中选择`Default->PHP Web Application`。
在右侧菜单中点击`Server`旁边的`...`按钮，添加新的服务器配置。

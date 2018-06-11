# 快速安装PEAR和使用PECL安装扩展

by HyperQing

## 背景

在Mac中进行开发，希望能够使用MongoDB扩展和XDebug进行开发。其他平台和安装其他扩展同理，可参考本文。

## 方法

官网下载PEAR非常慢，本文档同一目录下提供了`go-pear.phar`脚本。

这里假定你已经将`go-pear.phar`下载到`~`目录。

1. 安装pear。（对于Mac来说，几乎都要加sudo来进行操作，Linux如果是非root用户同理。）
```
cd ~
sudo php go-pear.phar
```
2. 正常情况下，可以直接安装mongodb和xdebug驱动。
```
pecl install mongodb
pecl install xdebug
```
但鉴于网速问题，可以预先下载压缩包再本地安装。

建议直接通过浏览器或其他下载工具（curl/wget/迅雷等随你），直接下载文件。
>https://pecl.php.net/get/mongodb-1.4.4.tgz

>https://pecl.php.net/get/xdebug-2.6.0.tgz

>如果链接失效，可以去https://pecl.php.net搜索即可。

3. 下载完成后，继续安装。假定你已经下载到`~`目录。
```
cd ~
sudo pecl install xdebug-2.6.0.tgz
sudo pecl install mongodb-1.4.4.tgz
```

4. 如无意外应该编译完成，并提示你将一些配置放进`php.ini`配置文件中。

这个是XDebug和MongoDB的配置示例，将其放入到`/etc/php.ini`中。你可能需要使用sudo打开编辑文件。如果是用vim编辑，你可能还需要`:wq!`强制写入。
```
extension = mongodb.so
zend_extension=/usr/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so

[xdebug]
xdebug.remote_enable=1
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_handler="dbgp"
```
**注意**zend_extension后面的值以你编译完成后的信息为准，可能和下面示例的有差异。

5. 查看是否安装成功
```
php -m | grep mongodb
php -m | grep xdebug
```
见到有mongodb和xdebug字样输出即安装成功，无输出则安装失败。

## 注意

以下涉及`brew`的内容仅适合 macOS 系统使用。

如果执行`pecl install xxxx`过程遇到缺少`phpize`的问题，执行下面这个语句进行安装autoconf即可解决。
```
brew install autoconf
```

如果遇到找不到`pcre.h`头文件的，安装这个。
```
brew install pcre
```

如果你连`brew`都没有的，请先安装Homebrew。
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
>https://brew.sh/

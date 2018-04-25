# 申请免费HTTPS证书

摘要 by HyperQing 2018-04-24

[TOC]

这里使用 Let's Encrypt 提供的免费证书。为了申请这个证书需要安装并运行 certbot 程序，具体见 certbot 官网。

certbot官网：https://certbot.eff.org/

可以申请**单域名证书**和**通配符证书**，都是免费的，单次有效期90天，可通过命令自动续期。

下面是部分内容的摘要和提示。

以官网页面中选择 None of the above on Debian 9 为例（因为通常会在不同的地方使用同一个证书，所以不选nginx、apache，但操作同理）。

具体操作请根据你的环境和实际需要，从官网获取操作信息。

## Install

安装certbot时需要用到stretch-backports，如果你没有的话，看这个链接进行安装。
https://backports.debian.org/Instructions/

如果你要申请通配符证书的话，遗憾的是，用来从 Let's Encrypt's ACMEv2 server 自动获取通配符证书的 Certbot's DNS 插件到目前为止还未投入使用。

不过很快就能用了。如果你不想等的话，可以用这个Dokcer版本的来代替。
https://certbot.eff.org/docs/install.html#running-with-docker

也可以通过这篇文章所述方法获取 http://mp.weixin.qq.com/s/xXJTbsOJ6aSOj2PW2K4Fug

>**通配符证书（wildcard certificate）**指的是`*.domain.com`这种形式，不包括`domain.com`本身，需要另外申请。

## Get Started

certbot 本身有很多插件来进行获取和安装证书。安装证书是指安装到nginx或apache。
如果不需要安装到特定的地方，那么仅仅只需获取证书即可。

文章提及`webroot`插件，笔者未使用过，效果未知。使用`webroot`插件有注意事项。

## Automating renewal

证书默认有效期3个月，执行命令即可创建计划任务，自动更新证书。

## 查看和管理证书

https://certbot.eff.org/docs/using.html#managing-certificates
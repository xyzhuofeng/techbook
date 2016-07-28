##CentOS7-使用Git部署项目

by HyperQing 2016-03-07

>Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。 Git 是 Linus Torvalds 为了帮助管理 Linux 内核开发而开发的一个开放源码的版本控制软件。

##常用的两种部署方式

 - FTP上传
 - Git部署（推荐）

##FTP上传

（本文不叙述该方法操作）

通常使用FTP软件，从客户端连接到主机进行文件传输。客户机安装FTP软件后，设置主机地址、登录账号、密码，即可连接到主机的文件系统，进行上传下载（需要有相应的操作权限）。

笔者在这里推荐WinSCP和FileZilla（开源）。有中文界面，持续更新，功能使用，最重要的是能满足部署项目和部署时自带编辑器方便修改配置的需求。

笔者不推荐的原因在于：FTP上传很依赖客户机到主机的网络环境，笔者上传个Thinkphp项目，区区几M的项目搞了二十多三十分钟，各种上传失败，断开连接，上传不完整、上传慢到一种境界，然后又要重新来……也许是笔者的所处的校园网环境问题吧。

另外一个问题是，每次代码有了更新，都要改配置文件，将本机测试配置换成服务器配置什么的。有时忘了改，部署上去就出事了。还有就是，如果上传中断不完整，要重新传的话，网站在该期间是不可用的，相当影响网站可用时间。

总之，在我的环境中，我是不推荐使用的了。

##Git部署

Git是众所周知的版本控制系统，在此不再赘述。

笔者推荐Git的原因在于：笔者所用的阿里云主机Centos7自带Git工具。这不是重点，没有的话，装上就好。

重点在于：不依赖客户机和主机的网络质量，以及基于Git的特性，发布时可以不改半点代码即可部署，且每次部署都是增量的热部署。网站出现BUG不可用？修改代码传到git上，主机一句命令即可部署。用户只需刷新一下页面就能得到正常的页面（PHP项目）。

注：由于是增量部署，网站可以在保持其他部分可访问的状态下，进行升级或修复BUG。

至于第一点原因，部署过程仅仅只是主机和Git服务器连接传输代码文件而已，和客户机无关。这里，你可能会用Github（访问慢，校园内可能打不开）、coding.net（推荐）、Git@OSC（开源中国）等作为你的Git服务器。

主机是阿里云的，Git是知名服务供应商提供的，所以部署时的传输速度自然不俗。

##Git部署操作
以下操作，笔者使用XShell软件连接主机来完成。

如果你是首次进行Git操作，建议使用`SSH-keygen`命令生成Git密钥来登录你的远程仓库，不仅安全而且免除多次输入账号密码的麻烦。

先查看.ssh目录是否存在，如果不存在，请建立。
首先，确保你当前打开了这个目录 ~ (用户目录) 效果看起来像这样：
```
[root@localhost ~]#
```
如果不在~ (用户目录)中，请进入到该目录，命令如下：
```
cd ~
```
在~目录下创建一个隐藏文件夹.ssh（文件夹名前面带点即是隐藏），更改文件夹权限为700
```
mkdir .ssh
chmod 700 .ssh
```
然后创建密钥，直接连按三次回车，第一次是指定目录，第二第三次是passphrase(私钥的密码，留空也可)
```
ssh-keygen -t rsa
```
此时.ssh文件夹中多了个`id_rsa.pub`公钥文件和`id_rsa`私钥文件。
打开`id_rsa.pub`并复制公钥（XShell软件支持复制）。打开并登陆到你的Git网站（如Github），在个人设置中的SSH设置中，贴入刚刚复制的公钥。保存即可生效。现在你可以通过SSH链接（如git@git.conding.net）来传输代码。

**以上代码仅需部署一次。**

----

**以下是首次部署项目代码的操作**

`cd`命令进入到主机的网站目录中，笔者的主机环境的目录是/usr/share/nginx/html
```
cd /usr/share/nginx/html
```
将当前目录初始化为本地仓库（只需初始化一次）
```
git init
```
为这个本地仓库添加一个远程仓库（`git remote add`），仓库名自定义为origin（算是惯例吧），后面那串地址是SSH地址（通过密钥登录），可以是HTTPS地址（通过账号密码登录），看起来像这样：
https://git.coding.net/username/xxxxx.git
```
git remote add origin git@git.coding.net:username/xxxx.git
```
从Git远程仓库origin中拉取master分支到本地master分支
`git pull <远程主机名> <远程分支名>:<本地分支名>`
```
git pull origin master:master
```
项目代码已经出现在当前文件夹
**部署操作到目前为止全部结束**

----

##维护项目

当项目代码变更，且`git push`到Git服务器上后，需要在服务器执行以下操作来获取更新。

切换到网站目录
```
cd /usr/share/nginx/html
```
拉取master分支
```
git pull origin master:master
```
嗯，是的，代码已经更新好了。就是这么简单！

顺利的话，你会看到类似这样的提示
```
$ git pull origin master:master
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From git.coding.net:clyoko/mabi
   c3cd26f..72227db  master     -> master
   c3cd26f..72227db  master     -> origin/master
warning: fetch updated the current branch head.
fast-forwarding your working tree from
commit c3cd26f58dd925dd92530cd6ae23a4c23a4cb63d.
Already up-to-date.
```
即使是重复执行该句也无所谓，它会提示：
```
$ git pull origin master:master
Already up-to-date.
```

从此，愉快地部署你的项目吧！

-----
####2016-03-07更新
在阿里云使用git方案部署代码时，云盾服务会提示/.git/config会造成信息泄露，如果你使用的是nginx服务器软件
请在网站配置文件中，加入这段：
```
#禁止访问/.git目录
location ^~ /.git {
    deny all;
}
```

# CentOS7 SSH2-RSA配置

[TOC]

by HyperQing
已适配阿里云，主机环境：CentOS 7

>关于**SSH**，从客户端来看，SSH提供两种级别的安全验证。

>第一种级别（基于口令的安全验证）
只要你知道自己帐号和口令，就可以登录到远程主机。所有传输的数据都会被加密，但是不能保证你正在连接的服务器就是你想连接的服务器。可能会有别的服务器在冒充真正的服务器，也就是受到“中间人”这种方式的攻击。

>第二种级别（基于密匙的安全验证）
需要依靠密匙，也就是你必须为自己创建一对密匙，并把公用密匙放在需要访问的服务器上。如果你要连接到SSH服务器上，客户端软件就会向服务器发出请求，请求用你的密匙进行安全验证。服务器收到请求之后，先在该服务器上你的主目录下寻找你的公用密匙，然后把它和你发送过来的公用密匙进行比较。如果两个密匙一致，服务器就用公用密匙加密“质询”（challenge）并把它发送给客户端软件。客户端软件收到“质询”之后就可以用你的私人密匙解密再把它发送给服务器。
用这种方式，你必须知道自己密钥的口令。但是，与第一种级别相比，第二种级别不需要在网络上传送口令。
第二种级别不仅加密所有传送的数据，而且“中间人”这种攻击方式也是不可能的。
——百度百科"SSH"

----
### 这里使用Xshell软件连接主机
如果你使用的是putty软件，客户机操作仅供参考，putty有类似的功能，请仔细找找。

**下述在你的客户机上进行，这可能是你的台式机或笔记本**
 1. 在Xshell中，打开  菜单栏->"工具(T)"->"新建用户密钥生成向导"。
 2. 密钥类型改为"RSA"，密钥长度"2048"，点击"下一步"。
 3. 稍等，提示“公钥成功生成”，点击"下一步"。
 4. 按需修改密钥名称，如果你要创建多个密钥的话，请更改名称。设置"给用户密钥加密的密码"，点击“下一步”。**这就是引言中提到的SSH2中必须知道自己密钥的口令**
 5. 选择公钥格式"SSH2 - OpenSSH"，点击"保存为文件"，将公钥放到你的电脑里。一会儿将会把这导入到主机指定文件中。点击"完成"。
 
 ----

**下述在你的服务器上进行，这可能是你的主机或虚拟主机**
**使用root账号登录你的主机**

注意：如果你没有root账号，请使用能够使用sudo命令的账号，进行操作。
如此，你接下来的操作将要这样输入：
```
sudo cd .ssh         //例子
sudo touch config    //例子
```
首先，确保你当前打开了这个目录 ~ (用户目录)
效果看起来像这样：
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
进入.ssh目录，在该目录下创建一个空白文件authorized_keys，并更改该文件权限为600
```shell
$ cd .ssh
$ touch authorized_keys
$ chmod 600 authorized_keys
```
使用vim打开该文件
```shell
$ vim authorized_keys
```
将上述客户机操作中导出的公钥文件内容复制一下
按 **i** 进入编辑模式，按下鼠标右键粘贴公钥。
看起来像这样：
```
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQELFFfIWTLLzs7Ens7EnTC5+qHk+D7hfvyVXyqZ5uC8e5meZLtgq/0NKOMJBLFFfIWTLLzs7EnFfIWTLLzs7EnJtJeLcRb/SiciNCYoG+1hthmQNXKjuYjLMJDd1iLfYetFyLBLFFfIWTLLzs7En1Gv5VAHuG0j2ILTMn1RLFFfIWTLLzs7EnmGRAx6xnvTwFLFFfIWTLLzs7En8zLFFfIWTLLzs7EnLLzs7EntvjQQ0zAauWnQfb9ZIH2sZhJF+s3l/ChL9jwTbg0LFFfIWTLLzs7EnIWTLLzs7Enr1AjiqI4wgLLFFfIWTLLzs7Ens7EnIWTLLzs7EnEhQWTN+DMs8/B1Gw==

```
粘贴完毕后，按下 **Esc** 键退出编辑，输入 **冒号（shift+;）** 和 **wq** 保存并退出。
```
:wq
```
打开SSH的配置文件，以启用SSH2登录。
```shell
$ vim /etc/ssh/sshd_config
```
文件包含了一些设置（节选了部分）：（如果前面有#符号，请记得去除以启用该项设置）
```
Port 22    //端口号,建议修改为其他，至少1000以上，避免和其他端口冲突
Protocol 2  //使用SSH2，设置为1，则是使用SSH1
RSAAuthentication yes  //启用RSA验证
PubkeyAuthentication yes  //启用公钥验证
AuthorizedKeysFile  .ssh/authorized_keys  //公钥路径
PasswordAuthentication no //禁用密码登录
```
编辑完毕后，按下 **Esc** 键退出编辑，输入 **冒号（shift+;）** 和 **wq** 保存并退出。
```
:wq
```
重启sshd服务
```
systemctl restart sshd
```
重新登录，分别使用密码和私钥进行登录以检查是否设置有效。

**注意！！如果你更改了端口号，请在Xshell中同时更改。**



###How To Install Fail2Ban On CentOS 7
###在CentOS7安装Fail2Ban
[http://www.unixmen.com/install-fail2ban-centos-7/?utm_source=tuicool](http://www.unixmen.com/install-fail2ban-centos-7/?utm_source=tuicool)

by oltjano terpollari

Brute force attacks are a way for malicious hackers to get access on your machine so in order to protect from these kind of attacks you need to prepare. A very good solution is the use of an intrusion prevention framework on your server such as **Fail2Ban** which will provide security on your server by blocking and banning the ip address from which the attack is coming from.

暴力破解攻击是一种恶意行为，黑客将可能获得在您的机器的SSH（账号密码）。为了防止这种攻击，你需要做一些工作。 一个很好的解决方案是，在您的服务器使用一个入侵预防框架，例如**Fail2Ban**，它将通过阻断和禁止ip地址的攻击，为你的服务器提供安全报障。

Experiencing ssh attacks on your server is a real struggle and I am sure you don’t want to be part of that so better follow the instructions on this tutorial in order to be prepared for the future.

遇到ssh攻击你的服务器是一个真正的挑战，我敢肯定你不想遇到，所以更好地是，按照本教程的说明来为未来做好准备。

###What Is Fail2Ban

**Fail2Ban** is a very useful piece of software widely spread in the industry, reduce the rate of incorrect authentications attempts with the main goal of preventing brute force attacks on various services such ssh, apache, courier and many others. It basically scans log files for finding malicious IP addresses with many password failures.

Fail2Ban是一个非常有用的软件，在业内广为传播。减少错误的认证尝试防止暴力袭击的，主要目标ssh等各种服务,apache,快递和许多其他人。 它基本上扫描日志文件寻找恶意IP地址与许多密码失败。

However you should always keep in mind that Fail2Ban does not protect your services from weak authentications so make sure you use strong enough passwords and also two factor or public/private authentication mechanisms.

但是你应该总是记住，Fail2Ban不保护用弱密码登录的主机，所以确保你使用足够强大密码，还有两个因素或公共/私人身份验证机制。

###How To Install Fail2Ban On CentOS
The first step we need to take for installing Fail2Ban on our CentOS machine is to make sure that we have root privileges, the following command will help to login as a user with root privileges.

第一步我们需要安装Fail2Ban，CentOS机器是确保我们有根(root)的特权,下面的命令将有助于登录使用root特权的用户。
```
su root
```
The command for logging as root is shown below.
作为根用户日志如下所示的命令。
```
su root
```
And the prompt changes.
和提示的变化。

Once the user has gained full privileges on the system guaranteed by being root it is time to get into some real action. The next step consists in installing the **epel-release** which will help us to install extra packages from EPEL(Extra Packages for Enterprise Linux) on our CentOS machine.

一旦用户获得特权的系统保证被根是时候进入一些实际行动。 下一步是安装**epel-release**这将帮助我们安装额外的包从EPEL(Enterprise Linux额外包)在我们的CentOS的机器。

The following command will do the entire job for you.
下面的命令将为您完成整个工作。
```
yum install epel-release
```
Once the installation is finished you will be gifted with access to alot of new packages.and one of those is fail2ban which can be installed by using the following command.

一旦安装完成后会有天赋获得很多新的包。 其中之一就是fail2ban可以通过使用下面的命令安装。
```
yum install fail2ban
```
The above screenshot shows the command need to be used in order to install fail2ban on CentOS machines.

上面的截图显示了需要使用命令来安装fail2ban CentOS的机器。

Type **y** and hit **Enter** on your keyboard.
键入 **y** 和 **回车键**。

**y** again.

再次按**y**

The installation of fail2ban is finished now.

安装fail2ban现在完成时。

There are also many dependencies being installed such as fail2ban-firewall, fail2ban-sendmail, fail2ban-systemd, fail2ban-server and some others.

也有许多依赖被安装,如fail2ban-firewall fail2ban-sendmail,fail2ban-systemd,fail2ban-server和一些其他。

###A Very Basic Configuration
Fail2Ban is a very complicated tool and requires deep knowledge to be used the right way so instead of explaining it on this tutorial I  will do a very simple configuration and then teach you guys how to use it on another tutorial.

Fail2Ban是一个非常复杂的工具,需要深入了解要使用正确的方式而不是解释在本教程中,我将做一个非常简单的配置,然后教大家如何使用它在另一个教程。

The default configuration for Fail2Ban is kept under **/etc/fail2ban/jail.conf** but we are not going to directly edit as we don’t want to mess things up at the moment. So create a local copy of jail.conf by using the following command on your CentOS system.

Fail2Ban的默认配置保存在**/etc/fail2ban/jail.conf**中，但是我们不会直接编辑,我们不想把事情搞砸。 所以创建一个本地副本的监狱。 设计通过使用下面的命令在CentOS系统。
```
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```
 Use vim or nano to open the jail.local file like shown below.
 使用vim或者纳米打开监狱。 本地文件如下所示。
```
vim /etc/fail2ban/jail.local
```
Now scroll down and take a look at options such as maxretry which is the number of failures a user is allowed to have before getting banned, port which specifies port range to be banned, bantime is the number of seconds the malicious user is banned from the service, protocol which is the default protocol being used and a very important option that catched my eye is the ignoreip one.

向下滚动,看看选项等maxretry这是失败的数量允许用户禁止之前,港口它指定端口范围是被禁止的,bantime的秒数是禁止恶意用户的服务,协议这是默认所使用的协议,我的眼睛是一个非常重要的选项,那ignoreip一个。

Every IP address defined here will not be banned by Fail2Ban. This is very useful in case you or other users forget their password and try different combinations to find the right one. Several addresses can be defined using space separator.

这里定义每个IP地址将不会被Fail2Ban。 这是非常有用的,以防你或者其他用户忘记密码和尝试不同的组合,找到合适的一个。 几个地址可以使用空间定义分隔符。

###Conclusion
In this very detailed tutorial we took a very simple approach on how to install Fail2Ban on CentOS 7 operating system. We also covered a bit Fail2Ban default configuraition file, explaining different options and their usage. In another tutorial we will do a deep exploration of Fail2Ban so you can start mastering the tool for your own good and security.

在这个非常详细的教程,我们采用了一种非常简单的方法关于如何安装Fail2Ban CentOS 7操作系统。 我们也有点Fail2Ban覆盖默认configuraition文件,解释不同的选项和它们的用法。 在另一个教程中我们将做一个深度的探索Fail2Ban所以你可以掌握自己的好和安全的工具。



 If you want to use Fail2Ban on Debian based systems, look at the following link.

如果你想使用Fail2Ban基于Debian系统,看看下面的链接。

- [How to Prevent SSH Brute Force Attacks with Fail2Ban on Debian 7](http://www.unixmen.com/how-to-prevent-ssh-brute-force-attacks-with-fail2ban-on-debian-7/)
如何防止SSH蛮力攻击Fail2Ban Debian 7

----

ignoreip = 127.0.0.1 #忽略的IP列表,不受设置限制（白名单）

bantime = 86400 #屏蔽时间，单位：秒  86400秒=24小时

findtime = 600 #这个时间段内超过规定次数会被ban掉

maxretry = 3 #最大尝试次数

backend = auto #日志修改检测机制（gamin、polling和auto这三种）

[ssh-iptables] #针对各服务的检查配置，如设置bantime、findtime、maxretry和全局冲突，服务优先级大于全局设置

enabled = true #是否激活此项（true/false）

filter = sshd #过滤规则filter的名字，对应filter.d目录下的sshd.conf

action = iptables[name=SSH, port=ssh, protocol=tcp] #动作的相关参数

sendmail-whois[name=SSH, dest=root, sender=fail2ban@example.com] #触发报警的收件人

logpath = /var/log/secure #检测的系统的登陆日志文件

maxretry = 5 #最大尝试次数

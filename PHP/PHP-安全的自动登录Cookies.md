#PHP-安全的自动登录Cookies

by HyperQing

在实现自动登录功能时，禁止直接将密码或简单加密的密文写入cookies。
例如
```
setcookies('username',$username);
setcookies('password',$password);
```
这样的写法是是极不安全的。XSS跨站点脚本攻击能够轻松地获取该用户名和密文，并用来登录。
XSS的其中一种方法就像这样：
```
http://localhost/test.php<script>alert(document.cookie)</script>
或者是URL编码后的：
http://localhost/test.php%3Cscript%3Ealert(document.cookie)%3C/script%3E
```
当用户打开这个链接时，URL中夹带的JS脚本就会把保存用户名和密码的Cookies，发送到盗号者手中。
为了演示，这里仅仅只是用一个弹窗来呈现效果。

如果你在使用Apache作为服务器软件，并再配置文件开启了相关功能，执行上面的语句时，可能会得到这样提示：

**Forbidden**
You don't have permission to access /test.php<script>alert(document.cookie)</script> on this server.

Apache/2.4.9 (Win64) PHP/5.5.12 Server at localhost Port 80

**但这不能成为直接把密码明文写入cookies的理由。**

----
###为了安全
**用于自动登录的cookies应该有如下特征：**

- cookies在用户修改密码后应该自动失效
- cookies不能直接存放用户名和密码明文或密文
- cookies被盗走后，用户通过修改密码，黑客无法使用该cookies进行登录
- 即使数据库被盗，黑客仍无法使用cookies登录，服务器密钥更改机制
- 每次登录后，cookies应当发生变化，黑客拿到前一次的cookies，即使有效期未过，也无法使用
- 使用Http-Only防止XSS方式读取该cookies

----

###设计方案

cookies键名直接md5(常量)，比如网站名称，文案词语等。
cookies值由几个部分的散列值（hash值）组成（使用SHA加密）：

 1. 登录名
 2. 有效时间（当前时间+过期时间）
 3. 密码密文前或后n位
 4. salt（加盐，即一些密钥，存放在服务器配置中）

准备好这几个要素后，使用SHA算法生成摘要，并写入cookies。该摘要信息即为token，同时将cookies的有效时间写入数据库，用于得知token是否已经过期。

这样有几个好处：

- 有效时间，保证每次登录的cookies值不一样
- 密码密文前或后几位， 保证用户修改密码后，使之前保存的（或被盗取的）cookies失效
- salt，当数据库被盗后，可以通过修改salt使所有用户的cookies失效，要求重新登录（这需要数据库保存密码时足够安全，即使密文被盗也无法简单破解，发生被盗事件后，应及时通知用户修改密码）
- 服务器存储有效时间，不会盲目使用cookies进行自动登录，需要校验有效时间。

当进行自动登录时，cookies值和数据库保存的token进行比较，一致的情况下，自动登录成功。

----

###一些解释

- 该token一次有效，每次登录都会重新写入，因为有效时间改变了。
- 该token并不是总是有效，有可能cookies已经失效，只要用户未登录，数据库仍然保留这条过期的token。通过数据库保存的有效时间信息可知该token已经过期，不接受客户端伪造的cookies。

例如：某客户端通过PHP程序伪造cookies（JS也可实现）
```
setcookies(盗取得知的键名，盗取得到的密文);
```
这里有个弊端就是，如果该cookies保存的token未过期，自然地数据库中的token也是未过期的。
那么黑客就可以在用户自动登录之前，抢先使用这个cookies进行登录。

关于改进的方法，可以将IP地址一同写入cookies中，一旦ip地址发生变化，token值也会变化，cookies校验失败，取消自动登录，要求用户重新登录。

----

##额外需求
- 可加入登录日志数据表及其相关记录登录地功能，甚至发送邮件通知异常登录。
- 如果用户的密码原文被盗，当异地登录时，应使用站内信通知其修改密码。
- 提供登录日志查询功能等

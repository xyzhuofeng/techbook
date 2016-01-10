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

###Forbidden
You don't have permission to access /test.php<script>alert(document.cookie)</script> on this server.

Apache/2.4.9 (Win64) PHP/5.5.12 Server at localhost Port 80

**但这不能成为直接把密码明文写入cookies的理由。**

为了实现这样的目标：

- cookies在用户修改密码后应该自动失效
- cookies不能直接存放用户名和密码明文或密文
- cookies被盗走后，用户通过修改密码，黑客无法使用该cookies进行登录
- 即使数据库被盗，黑客仍无法使用cookies登录，服务器密钥更改机制
- 每次登录后，cookies应当发生变化，黑客拿到前一次的cookies，即使有效期未过，也无法使用
- 使用Http-Only防止XSS方式读取该cookies

如此设计：
cookies键名直接md5(常量)，比如网站名称，文案词语等。
cookies值由几个部分的散列值（hash值）组成（使用SHA加密）：

 1. 登录名
 2. 有效时间（当前时间+过期时间）
 3. 密码密文前或后n位
 4. salt（加盐，即一些密钥，存放在服务器配置中）

准备好这几个要素后，使用SHA算法生成摘要，并写入cookies。

这样有几个好处：

- 有效时间，保证每次登录的cookies值不一样，

```php
假设前面已经进行登录验证
$username：登录名
$encrypt_pwd：密码密文

if(勾选“自动登录”){
	$username=
	setcookies(md5('站点名称或其他标记')，sha1(登录名+密码密文前或后n位，
		有效时间+salt));
}
```

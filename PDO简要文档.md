# PDO简要文档

整理 HyperQing 20170512

>PDO 即 PHP Data Object。以对象方式来操作数据库。

[TOC]

## 官网资料

> http://php.net/manual/zh/book.pdo.php

## 数据库使用流程

- 连接数据库
- 传入SQL语句
- 执行查询
- 遍历输出结果

## 连接数据库

> http://php.net/manual/zh/pdo.connections.php

要连接一个数据库，PDO通过构造函数来连接。

如下方代码所示，第一个参数`mysql:host=localhost;dbname=test`是指定数据源（DSN）。不难看出本次要连接的数据库是localhost主机的test数据库。
随后的两个参数是数据库账号和密码。

```php
// 通过构造函数创建一个连接对象
$db = new PDO('mysql:host=localhost;dbname=test', $user, $pass);
// 始终抛出异常
self::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
// 设置为utf8编码
self::$pdo->exec('set names utf8mb4');
// 随后可以使用$db进行数据库操作。
```

## 查询并遍历数据

> http://php.net/manual/zh/pdo.query.php

`PDO::query()`执行成功的话，会返回一个`PDOStatement`对象，失败则返回 `false`。

下面的代码中，`$result`尽管是个`PDOStatement`，但你依然可以对其进行遍历得到数据(本例中当作一个二维数组来用就好)。
```php
$db = new PDO('mysql:host=localhost;dbname=test', $user, $pass);
$result = $db->query('SELECT * from User');
foreach($result as $row) {
    print_r($row);
}
```

## 关闭连接

> http://php.net/manual/zh/pdo.connections.php

PHP有个神奇的特点，当脚本执行完毕时，会自动回收资源，包括数据库连接，运行时创建的对象等。
一般地不需要手动释放，在实际开发中也很难找到合适的释放时机。
因为某些Web框架可以做到在请求结束后进行自定义操作，可能是进行一些访问数据统计等。又或是进行其他操作，甚至没有其他操作。这样一来释放连接的时机就变得很微妙。与其操心这个，还不如交给脚本自动释放。

当然，也会有手动释放的场合，例如用户可能在Web中重新设置数据库密码，这就要求强制重新连接。

很简单，只需
```php
$db = null;
```

## 异常处理

> http://php.net/manual/zh/pdo.connections.php

试验这段代码的方法之一，停止 MySQL 服务即可。
```php
try {
    $db = new PDO('mysql:host=localhost;dbname=test', $user, $pass);
    foreach($db->query('SELECT * from User') as $row) {
        print_r($row);
    }
    $db = null;
} catch (PDOException $e) {
    // 这里做一些自定义处理，比如弹出一个报错页面
    // 或着输出报错信息，或着输出到日志
    print "Error!: " . $e->getMessage() . "<br/>";
    // 必要的情况下，强行退出程序，不再执行后面的代码
    exit();
}
```

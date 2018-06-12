# MVC框架揭秘（一）

by HyperQing

[TOC]

## 概述

当你开始关注并阅读本文时，你可能已经接触过一个或多个MVC框架了。理解框架所做的事情是一个迈向更高层次的门槛。当然，如果你能够深入理解框架的原理，我想没有什么能够难道你了。

本文以PHP语言为示例代码语言，框架选取ThinkPHP 5.1、Laravel 5、Symfony 4进行分析。

框架之所以复杂、难以理解在于这些地方：
- 时而动态调用（PHP的箭头->），时而静态调用（PHP的双冒号::）。
- 动态调用变量或方法，当前在调用什么难以捉摸。
- 容器和依赖注入
- 注解
- 路由
- ORM

还有很多……

我将尝试通过《MVC框架揭秘》系列来解释这些问题。

## 自动加载

最初的时候，将PHP和HTML混合到同一份文件进行书写。
```php
// index.php
<?php
$hello = "hyperqing";
echo "hyperqing";
?>
```
后来改成MVC模式，先定义一个控制器类。
```php
<?php
// controller/Index.php
class Index
{
	public function index()
	{
		echo "hello";
	}
}
```
在没命名空间的年代，通过调用类似`C('Index')`这样的自定义方法来引入`Index`控制器类。
```php
<?php
// common.php
function C ($className)
{
	require_once 'controller/' . $className . '.php';
}
```
直到后来命名空间出现，可以使用`spl_autoload_register`方法来注册自动加载方法，实现任意位置实例化类。
```php
<?php
// common.php
function proj_autoloader($class)
{
    // 根命名空间=>根文件夹
    $psr4 = [
        'app' => 'application',
        'hyper' => 'hyperqing\\libary'
    ];
    // 取出根命名空间
    $path_info = explode('\\', $class);
    // 将根命名空间转为目录
    if (!isset($psr4[$path_info[0]])) {
        throw new \ReflectionException('命名空间未声明: ' . $path_info[0]);
    }
    $path_info[0] = $psr4[$path_info[0]];
    // 重新组装路径
    $class = implode('\\', $path_info);
    if (!file_exists(WEB_ROOT . '/' . $class . '.php')) {
        throw new \ReflectionException('自动加载文件时未找到：' . WEB_ROOT . '/' . $class . '.php');
    }
    require_once WEB_ROOT . '/' . $class . '.php';
}

// 注册加载方法
spl_autoload_register('proj_autoloader');
```


pushHandler(new xxxHandler('',Logger::DEBUG))

monolog
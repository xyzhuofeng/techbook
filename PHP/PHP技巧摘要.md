## PHP技巧摘要（未完成预览版）

>部分摘自《Modern PHP(中文版)》一书

by HyperQing整理

使用生成器读取超大CSV文件
```php
<?
function getRows($file){
    $handle = fopen($file,'rb');
    if($handle===false){
        throw new Exception();
    }
    while(feof($handle)===false){
        yield fgetcsv($handle);
    }
    fclose($handle);
}

foreach (getRows('data.csv') as $row){
    print_r($row);
}
```
更多示例见http://bit.ly/ircmaxwell

bindTo闭包（已拍照）


Zend OPcache 字节码缓存

默认情况没有启用，5.5开启已经内置于PHP核心中。

如果要编译

--enable-opcache

编译后 zend_extension = /path/to/opcache.so

如果忘记扩展文件目录

php-config --extension-dir

如果使用Xdebug，则在php.ini中需要先加载Zend Ocache再加载Xdebug

在phpinfo()中可以查看启用情况。

在php.ini中配置opcache

```
opcache.validate_timestamp = 1 // 如果在生产环境中设为0,opcache将无法检查文件变化
opcache.revalidate_freq = 0 // 靠这个自动重新验证缓存功能
opcache.memory_consumption = 64
opcache.interned_strings_buffer = 16
opcache.max_accelerated_files = 4000
opcache.fast_shudown = 1
```

=========

## 内置PHP服务器

php -S 0.0.0.0:8000

php -S 0.0.0.0:8000 -c app/config/php.ini

路由器脚本
php -S 0.0.0.0:8000 outer.php

检测是否使用内置服务器

```php
<?
if (php_sapi_name() ==='cli-sever'){
    // 内置服务器
}else{
    // 其他服务器
}
```



## 使用PHP编写命令行脚本

http://php.net/manual/wrapper.php.php
reserved.variables.argv.php
reserved.variables.agrc.php

 ## 过滤检查
 
```php
<?
// 正确用法，转义单引号和双引号，然后输出
htmlentities('<h1></h1>',ENT_QUOTES,'UTF-8'); 
// 删除除了邮箱合法内容以外的所有字符
filter_var('469379004@qq.com',FILTER_SANITIZE_EMAIL);
// 删除小于ascii32的字符，转义大于asxii127的字符
filter_var(
    'asd',
    FILTER_SANITIZE_STRING,
    FILTER_FLAG_STRIP_LOW|FILTER_FLAG_ENCODE_HIGH
);
// 验证通过
if (filter_var('asd',FILTER_VALIDATE_EMAIL)){
    // 验证通过
}
```
其他验证组件
- aura/filter
- respect/validation
- symfony/validator

```php
<?php
$password = filter_input(INPUT_POST,'password'); 
// password_hash()的密文要存varchar(255)方便存储比现在（60位）更长的密文

password_needs_rehash(); // 检查旧密文是否需要更新
```

## 日期时间和时区

php.ini

date.timezong = 'Asia/Shanghai'

```php
<?php
date_default_timezone_set('Asia/Shanghai');

$datetime = new Datetime();

DateTime::createFromFormat('Y-m-d H:i:s','2018-06-19 12:00:00');

$interval = new DateInterval("P2W"); // 时间间隔

$datetime->add($interval);
$datetime->format('Ym-d');
$period = new DatePeriod('开始时间dateTime',$interval,3); // 反向时间实例

foreach ($period as $date){
    echo $date->format('Y-m-d');
}

new DateTimeZone('Asia/Shanghai');
DatePeriod::是迭代器，可用于重复在日程表中记事

```

推荐存储UTC时间

## 字符编码

php.ini

default_charset = "UTF-8";

## 内置流封装协议

http实际上的PHP封装的协议
默认为file://

内置的还有
php://stdin

php://stdout 写入输出缓冲区

php://memoey  从内存读取数据，缺点是可用内存有限，使用temp更安装

php://temp 在没可用内存时使用临时文件代替

流封装协议http://bit.ly/s-wrapper

class.streamwrapper.php

stream.streamwrapper.eaxample-l.php

流上下文，流过滤器


## 异常

Exception

ErrorException

捕获全局所有未处理异常
```php
<?php
set_exception_handler(function (Exception $e){
    
});
// 还原成前一个异常处理程序
restore_exception_handler();
```

## 错误

```php
<?php
// 自己出发错误 
trigger_error();
```
开发环境
```
// 显示错误
display_startup_errors = On
display_errorss = On


// 报告所有错误
error_reporting = -1

// 记录错误
log_errors = On
```
生产环境
```
// 显示错误
display_startup_errors = Off
display_errorss = Off


// 报告所有错误，除了注意事项
error_reporting = E_ALL & ~E_NOTICE

// 记录错误
log_errors = On
```


## 全局错误程序

```php
<?php
set_error_handler(function($errno,$errstr,$errfile,$errline){
   // 处理错误 
});
```

其他见照片

## 主机相关


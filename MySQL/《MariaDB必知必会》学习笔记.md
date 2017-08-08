# 《MariaDB必知必会》学习笔记

>本书由[美]Ben Forta 著，张艺乐 译。

by HyperQing<469379004@qq.com>

[TOC]

## 基本语句

选择数据库
```sql
USE my_database;
```

返回可访问数据库的列表
```sql
SHOW DATABASES;
```

返回当前选择的数据库中可用表的列表信息
```sql
SHOW TABLES;
```

显示表结构
```sql
DESCRISE my_table;
```

显示表结构，同上
```sql
SHOW COLOMNS FORM my_table;
```

显示服务器状态
```sql
SHOW STATUS;
```

显示创建数据库和创建表时的语句
```sql
SHOW CREATE DATABASE;
SHOW CREATE TABLE;
```

显示授予用户的安全权限
```sql
SHOW GRANTS;
```

显示服务器的错误或警告信息
```sql
SHOW ERRORS;
SHOW WARNINGS;
```

查看有关SHOW的更多帮助
```sql
HELP SHOW;
```

MariaDB支持使用`INFORMATION_SCHEMA`来获取和过滤更多的Schema信息。

注释
>注意，Markdown语法高亮可能无法正确处理下方代码的高亮，但仍然是有效正确的代码。
```sql
SELECT 3*2;  -- 这是一个注释，该语句结果为6
# 这是一个注释，以#开头让整行都成为注释
/*这是一个
多行注释*/
```

## 检索数据

只返回不同的（唯一的）行，`DISTINCT`必须放在列名之前
```sql
SELECT DISTINCT name FROM my_table;
```
>**不能部分使用DISTINCT** DISTINCT关键字应用于所有列，而不仅仅应用于其后的一列。如果指定 `SELECT DISTINCT name ,id FROM my_table;` ，会检索所有的行，除非指定两列都不同。


排序
```sql
SELECT * FROM my_table ORDER BY id; --按id默认顺序排列
SELECT * FROM my_table ORDER BY id DESC; --按id倒序排列
SELECT * FROM my_table ORDER BY id,name; --默认顺序，按id排列后再按name排列
SELECT * FROM my_table ORDER BY id DESC,name ASC; -- 按id倒序排列，再按name顺序排列
```


## limit

```
limit a,b
```
a是从0开始的
```
第5行开始，返回5行。
limit 5,5
不超过5行。
limit 5 
```

## where

查询值为(不为)null的记录
```
where name IS [NOT] NULL
```
模糊匹配，`%`匹配任何数量任何字符，大小写由数据库配置决定，不能匹配NULL。
```
where name like '%'
```
模糊匹配，`_`匹配一个字符。
```
where name like '_'
```
正则表达式
```
where name REGXP '[0-9A-Za-z]'
```

## 字符串操作函数

`Concat()`拼接多个字符串
```
select Concat(name,'(',country,')')
```

```
去除两侧空格
Trim()
LTrim()
RTrim()

Upper() 大写
Lower() 小写
Left() 获取左端的字符
Right() 获取右端的字符
Locate() 搜索字符串
Substring() 求子串
Soundex() 获取单词声音数据，用于查找英文相似发音单词，如soundex('lee') = soundex('le')
```














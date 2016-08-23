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

## 检索数据

只返回不同的（唯一的）行
```sql
SELECT DISTINCT name FROM my_table;
```
>**不能部分使用DISTINCT** DISTINCT关键字应用于所有列，而不仅仅应用于其后的一列如果指定 `SELECT DISTINCT name ,id FROM my_table;` ，会检索所有的行，除非指定两列都不同。


注释
```sql
SELECT 3*2;  -- 这是一个注释，该语句结果为6
# 这是一个注释，以#开头让整行都成为注释
/*这是一个
多行注释*/
```
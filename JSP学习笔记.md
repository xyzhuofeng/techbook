#JSP学习笔记

>by HyperQing 20160922

[TOC]

## 注释
```java
<%-- 这是注释 --%>
```

## 指令

- page
- include
- tablib

## 脚本元素

普通代码

```java
<% JAVA代码 %>
```
声明全局变量
```java
<%! int a = 0; %>
```
>分号不能省略

表达式，最终结果换成字符串输出
```java
<%!=yourvalue %>
```
>不加分号


## 动作元素
```HTML
<jsp:include>先处理再包含
<jsp:param>参数
<jso:forward>服务器内部无条件跳转
```

## 内置对象

四类内置对象

1. `Servlet` ，包括 `page` , `config` 对象。
2. `IO` ,包括 `out` , `request` , `response` 对象。
3. `Context` ,包括  `session` , `application` , `pageContext` 对象。
4. `Error` ,包括  `exception` 对象。


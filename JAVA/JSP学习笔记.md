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

### out

输出和缓冲区处理

### request
本次请求相关信息，GET、POST

### response
设置响应头header（`refresh` , `location` 302 重定向），操作输出流，状态码(4xx , 5xx)。
```
response.sendRedirect(URI);// 302重定向
```

### 文件上传下载

文件上传，在 `servlet` 中通过 `request` 获取输入流。
文件下载，输出流。

### cookie

`request` 可以 `getCookies()` 。
`response` 可以 `setCookie()` 。

### session

类似 PHP 的 `$_SESSION` 。

### application

读写全局属性，获取 `servlet` 消息。`getServletContext()` 代替 `application` 对象。

### page

在jsp中使用servlet定义的方法。

### pageContext
获取上面提到的四类对象，可读写属性。属性可设置4种保存范围：page,request,session,application。

### config
获取初始化参数。

### exception
异常对象



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

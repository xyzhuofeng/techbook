# 快速学习XML

## XML文档格式

### 格式良好的和有效的XML

格式良好：
- 有开始标签和结束标签（空标签除外）
- 元素嵌套无交叉
- 一个元素内无同名属性
- 所有标签构成一个层次树
- **只有一个根标签**
- 没有对外部实体的引用（除非提供DTD）

### XML简单文档示例

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml version="1.0" encoding="UTF-8"?>
<!-- 这是注释 -->
<recipe>
    <recipename>Ice Cream Sundae</recipename>
    <preptime>5 minutes</preptime>
</recipe>
```

### xml文档声明
xml声明必须为第一行,且前面不允许存在空白（空格、Tab制表符或换行符等）；
```xml
<?xml version="1.0" encoding="UTF-8"?>
```

### 注释
```xml
<!-- 这是注释 -->
```

### 处理指令
```xml
<?处理指令名 处理指令信息?>
<!-- 例如 -->
<?xml-stylesheet type="text/css" href="xxxx.css"?>
```

### 属性
```xml
<student id="1">
</student>
```

### CDATA

大段转义文本使用，某些地方频繁使用`&lt;`，`&gt;`等转义字符
```xml
<![CDATA[
文本内容<student>这个标签不会被解析，原样保留
]]>
```

>注意不能包含字符串如`<![CDATA["字符串"]]>`，不能嵌套使用，可出现在任何地方。

## 命名空间

### 有前缀命名空间
```xml
<book xmlns:reading="http://my.com/reading">
```
>注意：xmlns和冒号和前缀之间不能有空白存在。
>当且仅当他们的名称相同时，两个命名空间才相同。即使前缀相同，名称不同的话，这两个命名空间也是不同的。
>命名空间区分大小写

### 作用域
一个标签如果使用了命名空间声明，那么该命名空间的作用域是该标签及其所有的子孙标签。
如果命名空间有前缀，那这个标签也应该要加前缀，来表示该标签属于该命名空间。

```xml
<readind:book xmlns:reading="http://my.com/reading">

```









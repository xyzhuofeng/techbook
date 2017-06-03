# 快速学习XML

>by HyperQing 20160701

[TOC]

## XML文档格式

### 格式良好的和有效的XML

格式良好的：
- 有开始标签和结束标签（空标签除外）
- 元素嵌套无交叉
- 一个元素内无同名属性
- 所有标签构成一个层次树
- 只有一个根标签
- 没有对外部实体的引用（除非提供DTD）

有效的：
- 使用DTD或XML Schema对XML内容进行约束

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
    <reading:title>这是一本书</reading:title>
</reading:book>
```

### 命名空间的名称
上面展示的命名空间名称是`http://my.com/reading`
这不一定是个域名，可以是任意的，但通常为了方便管理，会使用域名或者其他路径那样的东西（URI）

这些名称也是可以的：
```xml
"www.my.com"
"abc/zxc/ert"
```

-------

## XML Schema

用XML语法写出来的，用来约束XML内容的一种文件。

### XML Schema示例

文件first.xsd
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="symbol" type="xsd:string">
</xsd:schema>
```
以`xsd:schema`作为根元素，通常使用`xs`或`xsd`作为前缀。必须在根元素声明这个命名空间`"http://www.w3.org/2001/XMLSchema"`。

这里给出一个符合上述schema约束的XML文档。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<symbol>
    啦啦啦啦
</symbol>
```

对这个XML文档使用约束
```xml
<?xml version="1.0" encoding="UTF-8"?>
<symbol xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:ncNamespaceSchemaLocation="first.xsd">
    啦啦啦啦
</symbol>
```

### XML Schema 元素声明

用于声明一份XML文档应包含哪些元素。

#### 简单元素声明

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="symbol" type="xsd:string" />
</xsd:schema>
```
第2行声明这是一份schema文档，使用前缀xsd，空间名称为`"http://www.w3.org/2001/XMLSchema"`。
第3行声明一个元素，该元素名为`symbol`，类型为`string`。

元素定义中还有两个属性：`minOccurs`和`maxOccurs`
`minOccurs="0"`表示最小0次，即该元素可选，不是必须的。
`maxOccurs="unbounded"`表示无限制重复出现次数。

#### 复杂元素声明

指可拥有子元素或属性的元素。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="symbol">
        <xsd:complexType>
            <xsd:element name="title" type="xsd:string" />
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
```

#### 元素的引用
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="title" type="xsd:string" />
    <xsd:element name="symbol">
        <xsd:complexType>
            <xsd:element ref="title" />
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
```

#### 声明属性
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="symbol">
        <xsd:complexType>
            <xsd:element name="title" type="xsd:string" />
            <xsd:attribute name="isbn" type="xsd:string" />
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
```

## XML样式表：XSLT










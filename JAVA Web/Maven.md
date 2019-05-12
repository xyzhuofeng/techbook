# Maven 常用包

[TOC]

## Spring MVC

https://search.maven.org/artifact/org.springframework/spring-webmvc/5.1.6.RELEASE/jar

```xml
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-webmvc</artifactId>
  <version>5.1.6.RELEASE</version>
</dependency>

<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>4.3.23.RELEASE</version>
</dependency>
```

## Servlet-api 

https://search.maven.org/artifact/javax.servlet/javax.servlet-api/4.0.1/jar

>关于javax.servlet-api 和 servlet-api 区别
>https://blog.csdn.net/qq_20314665/article/details/73436510
```xml
<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>javax.servlet-api</artifactId>
  <version>4.0.1</version>
</dependency>
```

## Apache Commons Lang

https://commons.apache.org/proper/commons-lang/

```xml
<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-lang3</artifactId>
  <version>3.9</version>
</dependency>
```

## 单元测试

```xml
 <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>RELEASE</version>
    <scope>test</scope>
</dependency>
```

## Mockito

https://site.mockito.org

```xml
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-core</artifactId>
    <version>2.27.0</version>
</dependency>
```

## JSTL

https://search.maven.org/artifact/taglibs/standard/1.1.2/jar

```xml
<dependency>
  <groupId>taglibs</groupId>
  <artifactId>standard</artifactId>
  <version>1.1.2</version>
</dependency>
```
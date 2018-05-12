# 全栈魔法书

by HyperQing 2018-04-24

**禁止未经授权转载（具体见License）**

## 最近更新

魔法书又开更了

**团队管理工具/Gogs代码仓库实践**2018-05-12

## 介绍

这里是全栈魔法书，记载了作者学习探索过程中总结归纳的资料。作者平时就有整理文档的习惯，最初为了校内技术团队培训而编写，后来为个人技术发展而写。

框架工具纷繁复杂，掌握所有工具无补于事。只有掌握解决方案、生产实践，紧贴需求做技术研发，才是硬道理。

涉及领域较多，包括：

- 生产实践
- PHP
- HTML5+CSS3
- JavaScript
- 前端工程化
- APP、移动端Web
- MySQL
- Redis
- 系统架构
- Linux
- 树莓派

如果本文档对你有帮助，可以给个 star 表示支持。为了让你及时了解更新的部分，强烈建议关注本文档，本文档会不定时频繁更新。

## 互动

如果你有
1. 意见或建议。
2. 更好的解决方案。
3. 发现疏漏错误之处。
请到 Issues 发表，我会尽快回复你。

合作请联系：me@hyperqing.com

## 编写计划

- HTTPS 部署（优先）：因为后面的诸多产品都依赖HTTPS
- Docker 部署与监控（优先）
- 我是如何在自己的app上关注仓库的。
- 设计模式补充：强调如何应用
- 即时通讯：以APP为例展示
- 树莓派文档整理
- 解决方案大全：外包、快速快发
- 框架原理分析：论框架的诞生
- 再论cgi.path_info问题
- ThinkPHP5的PDO预处理：论证如何合理书写防御性代码
- OpenSSL常用操作：针对AES、3DES等操作
- 异常处理设计：如何编写合适的异常类并抛出异常
- PHP命令行工具编写：快速搭建你的PHP命令行工具
- 精通Git操作
- PHP7协程实战
- Redis队列和消息队列
- Gogs代码仓库部署（优先）：为小型企业和团队提供代码仓库解决方案（已完成）

## 已发布的内容

2018-04-24更新目录
```
根目录
│  .gitignore
│  Atom格式化代码ctrl_alt_L.coffee
│  README.md
│  Redis快速开始.md
│  vue使用element-ui的el-input监听不了回车事件.md
│  大型网站技术架构笔记.md
│
├─.idea
│  │  misc.xml
│  │  modules.xml
│  │  php.xml
│  │  techbook.iml
│  │  vcs.xml
│  │  workspace.xml
│  │
│  ├─dictionaries
│  │      Li.xml
│  │
│  └─inspectionProfiles
│          Project_Default.xml
│
├─CentOS7
│      CentOS7-MariaDB乱码解决方案.md
│      CentOS7-mysql修改密码.md
│      CentOS7-Mysql双机热备份.md
│      CentOS7-Nginx.conf配置.md
│      Centos7-phpMyAdmin安装.md
│      CentOS7-Redis配置文档.md
│      CentOS7-SSH2配置.md
│      CentOS7-使用Git部署项目.md
│      CentOS7.2-使用yum安装LNMP和配置文档.md
│      CentOS7.2-安装Swoole引擎.md
│      install.sh
│      替换文本.sh
│
├─Docker
│      CentOS7-LNMP-Docker实战.md
│
├─JAVA
│      Java多线程.md
│      JSP学习笔记.md
│
├─MySQL
│      《MariaDB必知必会》学习笔记.md
│
├─Nginx
│      Nginx-gzip压缩优化加载速度.md
│      nginx301跳转配置
│      Nginx三个版本的区别.md
│      Nginx基本操作与负载均衡
│      Nginx基本操作与负载均衡.md
│      Nginx适配Thinkphp的PATH_INFO的URL模式.md
│
├─PHP
│      cgi.path_info漏洞问题.md
│      curl获取天气xml.php
│      LNMP一键安装包说明.md
│      PDO简要文档.md
│      PHP-安全的自动登录Cookies.md
│      php.ini常用配置.md
│      PHP7-mcrypt代替方案OpenSSL.md
│      PHP7编译安装.md
│      PHPStorm快捷操作.md
│      结合PHPStorm使用Xdebug调试.md
│      读取XML的语句.md
│
├─python
│      python.md
│
├─其他
│      Git进阶与团队协作.md
│      网站搭建.md
│
├─前端
│      CSS溢出文本截断和滚动条自定义.css
│      Flex实现的页脚固定在页面底部效果.md
│      jquery-动态加载更多文章.js
│      vue-cli命令行工具基本使用方法.md
│      快速学习XML.md
│
├─树莓派
│      树莓派.md
│
├─设计思路
│      多人在线一对一即时聊天系统.md
│      高级文件下载实现.md
│
└─设计模式
        PHP设计模式速查.md
```

## License

**声明**
1. 本仓库的内容大部分经过作者实践，或以其他方式验证，尽量确保文章内容有效可用。尽管如此，恳请大家在阅读过程中发现问题后，在issue中提出，谢谢大家。
2. 作者在生产环境的实践可能并不一定适合你，请根据你的项目现状采取合适的方案。
3. 欢迎提出建议和意见。尽管本仓库主要由 HyperQing 进行维护，但文档灵感、生产实践、归纳总结等大部分都来自于团队、友人、网友、同行等的大力支持。没有他们，将没有本仓库的持续发展。

**你可以进行这些操作：**
1. 学习、实践本仓库包含的技术。
2. 习得的内容（包括文章提及到原创非专利技术）均可用于商业用途（默认授权且无需支付授权费用）。
3. 疏漏之处，请及时指正。发布 issue 提出即可。
4. 引用请保留仓库地址和作者信息。技术是不断更新的，我不希望被引用后，读者看到的都是过时的资料。

**你不可以进行这些操作：**
1. 禁止未经授权的商业用途，包括但不限于：商业售卖、打包或部分打包出售、知识付费等。如果有网友发现，请及时在issue举报。
2. 其他未声明的侵犯知识产权行为。

**Thanks！**

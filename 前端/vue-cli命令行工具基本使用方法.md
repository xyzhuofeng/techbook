# vue-cli命令行工具基本使用方法

by HyperQing 整理 2017-06-27

安装nodejs，自带npm
使用淘宝npm镜像，此后使用cnpm命令代替npm
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

原文见：http://cn.vuejs.org/v2/guide/installation.html#独立构建-vs-运行时构建

全局安装 vue-cli
```
cnpm install --global vue-cli
```
创建一个基于 webpack 模板的新项目
```
vue init webpack my-project
```
安装依赖，走你
```
cd my-project
cnpm install
```
以node服务器运行
```
cnpm run dev
```
node服务器运行后，访问地址
```
http://localhost:8080
```
自带热更新特性，即修改代码后保存，浏览器不用刷新即可看到效果。

## 创建项目
创建单页应用项目
```
vue init webpack my-project
cd my-project
cnpm install
```
为生产部署版本安装vue-router vue-resource
```
cnpm install vue-router vue-resource --save
```
为调试开发版本安装vue-router vue-resource
```
cnpm install vue-router vue-resource --save-dev
```
## 调试运行

运行服务器，在本地浏览器中调试开发
```
cnpm run dev
```

## 构建项目

构建完毕，将在项目目录下生成dist纯静态项目文件夹，将该文件夹内容部署到 Nginx 服务器中即可。
```
cnpm run build
```

# Laravel结合前端工程化实践

by HyperQing 2017-12-07 禁止转载，违者追究责任

## 核心技术
**Laravel-Mix** 一个强大的 Nodejs 工具。

## 适用场景

（待续）



相关资料：
- https://d.laravel-china.org/docs/5.5/frontend
- https://d.laravel-china.org/docs/5.5/mix

成功实现在后端项目中使用前端工程，例如在PHP模板中使用vue组件。

曾经我们担心的纯前端vue造成的SEO伤害已经解决。

不但如此，还能使用webpack打包压缩和版本化资源文件。

结论：前后端成功实现适度分离，现在可以完全使用npm各种包来构建应用，并且不会造成SEO伤害，同时路由和权限管理仍然可以由后端完成，确保系统安全（当然也可以前端完成）。

早期实践得知，vue工程和后端工程结合存在巨大的困难，比如默认SPA单页应用，难做多页面。页面命名书写规范不同，导致后端无法直接使用vue组件等

几日前也发现问题，随着页面重复的部分越来越多，无法简单粗暴分割页面部件

在这个背景下，发现了前述神技，vue组件化得以和后端框架和谐共存。




laravel有一个解决前后端交叉引用打包压缩各种问题的神器
laravel-mix

首先是常规方式npm install
书写vue component

纯前端的话，到目前为止需要一个index.html来调用vue component

index.html通常在根目录下,对于vue-cli而言，SPA优先
整个项目就一个index.html
跳转啥的全是前端路由

然而，对于后端来说，各个URL都有单独的页面，目录藏得很深

单纯vue-cli+webpack适应这种环境，要手写很多配置脚本
现在有laravel-mix工具
vue component照写，ES6啥的一切照旧

最大的问题无非就是引入app.js，app.css时引起的巨大麻烦

laravel-mix做了这样一件事情，打包压缩照旧，“自动把最终资源搬运到合适的地方”
“并生成一个资源路径映射表”

laravel-mix是个nodejs工具
主要功能就是全自动打包压缩并生成映射表
然后php读取映射表得到真实路径

laravel-mix还支持很多自定义操作，毕竟只是一堆js，比如autoprefix自动加CSS3的前缀

当然，单纯压缩打包普通css、js文件也是ok的


这种功能也保留下来了
并非每次都要手动npm run dev

毕竟编译一次要等

经过这次探索后，自研产品的开发方式，得到进一步升级
毕竟为了使用tp5，而让前端放弃各种高端工具实在太可惜

react也是支持的哈哈哈
还有jquery,bootstrap都能很好的工程化
具体还要看产品用户群体



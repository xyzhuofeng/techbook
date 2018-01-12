# CentOS 7 Docker实战

by HyperQing 2018-01-12

## 安装Docker

从 yum 安装
```
yum install docker -y
```

启动 docker 服务，设置开机自启
```
systemctl start docker
systemctl e
nable docker
```
查 docker 看版本
```
docker --version
```

## 基本操作


使用当前目录的Dockerfile创建镜像。
```
docker build -t 镜像名 目录
```
```
docker build -t hyperqing/php-helloworld .
```


运行容器

-d: 后台运行容器，并返回容器ID；
```
docker run -d -p 8080:8080 allovince/php-helloworld
```


查看运行中的容器
```
docker ps
```
* `-a` :显示所有的容器，包括未运行的。

删除容器
```
docker rm 容器id
```
* `-f` :通过SIGKILL信号强制删除一个运行中的容器
* 

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


```
docker run -d -p 8080:8080 allovince/php-helloworld --name hello
```
* `-d`: 后台运行容器，并返回容器ID
* `--name`: 为容器命名，方便操作管理


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

查看现有镜像
```
docker images
```

删除现有镜像
```
docker rmi 镜像名
```

## 操作规范

### MySQL 5.7

Dockerfile文件
```
FROM mysql:5.7
```
CentOS 7 的MySQL数据文件在`/var/lib/mysql`目录中

```
docker run -d --name project-mysql -e MYSQL_ROOT_PASSWORD=qIpa56F9a1vY3c9aT -v /var/lib/mysql:/var/lib/mysql hyperqing/mysql
```


docker exec -it project-mysql bash
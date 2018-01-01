# Nginx基本操作与负载均衡.md

by HyperQing 2018-01-01

## Nginx基本操作

>参考资料：http://nginx.org/en/docs/beginners_guide.html

### 概览

* stop — fast shutdown
* quit — graceful shutdown
* reload — reloading the configuration file
* reopen — reopening the log files

### 立即结束Nginx

强制结束进程。
```
nginx -s stop
```

### 优雅结束Nginx

会等待当前请求处理完毕后结束进程。
```
nginx -s quit
```

### 重载Nginx

```
nginx -s reload
```
当主进程收到重新加载配置的信号后，它先检测新配置的语法是否规范，然后开始尝试加载新的配置。如果上面的步骤成功，主进程开始启动新的工作进程并且发停止信号给旧的工作进程；否则，主进程回滚到改变前的配置，并继续使用旧的配置工作。旧的工作进程接受到停止工作信号，它停止接受新的连接请求，但继续处理当前的请求知道这些请求被处理完成。最后，旧的工作进程退出。

## 配置负载均衡SLB

修改原来的网站配置`horizon.conf`
```
server {
    listen 8123; # 将80端口改成其他内部端口
    # 其他配置
}
```

Nginx配置添加负载均衡配置`nginx.conf`
```
http {
    upstream www.domain.com {
      server 127.0.0.1:8080;
      server 12.34.56.78:8080;
    }
}
```
对域名`www.domain.com`进行负载均衡处理。

其中,通过不同的参数可以调整权重和使机器上下线。

server 192.168.0.100:80
负载均衡后端RealServer的IP或者域名，端口不写的话默认为80。高并发场景用域名，再通过DNS进行负载均衡

* weight=5  权重，默认为1，权重越大接收的请求越多
* max_fails=2   最大尝试的失败次数，默认为1,0表示禁止失败尝试
* fail_timeout=10s  失败超时时间，默认是10秒，通常3s左右比较合适
* backup  热备配置，前段RealServer出现问题后会自动上线backup服务器
* down  标志服务器不可用，这个参数通常配合IP_HASH使用


添加监听外部80端口的负载均衡文件`SLB.conf`
```
server {
    listen 80;
    server_name www.domain.com;
    location / {
        proxy_pass http://www.domain.com; # 使用前述定义的www.domain.com负载均衡
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
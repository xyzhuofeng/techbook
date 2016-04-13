首先为yum添加epel源:
```
yum install epel-release
```

```
yum install redis
systemctl start redis
systemctl enable redis
```

```
yum install php56w-pecl-redis 

systemctl restart php-fpm

telnet 127.0.0.1 6379

```
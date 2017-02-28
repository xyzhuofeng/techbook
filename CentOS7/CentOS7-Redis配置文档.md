首先为yum添加epel源:
```
yum install epel-release
```

```
yum install redis -y
systemctl start redis
systemctl enable redis
```

```
yum install php71w-pecl-redis -y

systemctl restart php-fpm

redis-cli

```
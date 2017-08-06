

运行Redis
```
redis-server redis.conf
```
windows中
```
redis-server redis.windows.conf
```

打开redis-cli
```
$redis-cli
127.0.0.1:6379>
```
测试
```
127.0.0.1:6379> PING

PONG
```

保存
SET runoobkey redis
读取
GET runoobkey
删除
DEL runoobkey
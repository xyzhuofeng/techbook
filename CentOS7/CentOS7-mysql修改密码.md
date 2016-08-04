# 5.6
```
mysql -u root

mysql> use mysql;

mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';

mysql> FLUSH PRIVILEGES;

```

# 5.7
```
SET PASSWORD = PASSWORD('new password');
 FLUSH PRIVILEGES;
```
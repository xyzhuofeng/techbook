# PHP7.1 mcrypt_module_open()替换方案

https://segmentfault.com/q/1010000007210963?_ea=1272687

http://php.net/manual/zh/migration71.deprecated.php

## PHP 7.1.x 中废弃的特性

### ext/mcrypt

mcrypt 扩展已经过时了大约10年，并且用起来很复杂。因此它被废弃并且被 OpenSSL 所取代。 从PHP 7.2起它将被从核心代码中移除并且移到PECL中。

### mb_ereg_replace()和mb_eregi_replace()的Eval选项

对于mb_ereg_replace()和mb_eregi_replace()的 e模式修饰符现在已被废弃。
已适配阿里云CentOS7主机

打开LNMP.org官网下载页http://lnmp.org/download.html
获取.tar.gz文件下载地址

使用curl下载文件
```
cd ~
curl -L https://api.sinas3.com/v1/SAE_lnmp/soft/lnmp1.3beta-full.tar.gz -o lnmp.tar.gz
```
下载完成后，解压
```
tar -xvf lnmp.tar.gz
```
进入目录，目录名视版本差异有所不同
```
[root@k4Z ~]# ls
lnmp1.3-full  lnmp.tar.gz
[root@k4Z ~]#  cd lnmp1.3-full
```
执行安装 
```
./install.sh lnmp
```
如需要安装LNMPA或LAMP，将./install.sh 后面的参数替换为lnmpa或lamp即可。

安装过程需要几十分钟到几小时左右。

安装缓存加速
```
./addons.sh install opcache
```




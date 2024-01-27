---
layout:     post
title:      TP5加Apache或者Nginx
subtitle:   本地开发MAMP配置
date:       2024-01-27 15:06:12 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - PHP
---


#### MAMP配置

版本：`6.8.1`

#### 数据库

数据库：`MySQL` 

##### Apache配置【推荐】

**伪静态**

放到`Additional parameters for <Directory> directive:`输入框下

```
<IfModule mod_rewrite.c>
Options +FollowSymlinks -Multiviews
RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php?/$1 [QSA,PT,L]
</IfModule>
```


##### Nginx配置

- Tips
- 有时候莫名其妙的关不掉Nginx服务或者各种500，可尝试重启Mac电脑  

**伪静态**

`try_files` 可以不配置

```
# try_files 参考【可不配置】 ===>
try_files $uri $uri/ /index.php?$query_string;
```

放到`Custom*:`输入框下

```
# MAMP 配置时候只需要填写以下内容

if (!-e $request_filename) {
    rewrite ^/([0-9]+)$ /home/show/index?roomnum=$1 last;
    rewrite ^(.*)$ /index.php?s=$1 last;
    break;
}
```


#### TP5伪静态配置

```
# Nginx

location / {
    if (!-e $request_filename) {
     rewrite ^/([0-9]+)$ /home/show/index?roomnum=$1 last;
     rewrite ^(.*)$ /index.php?s=$1 last;
     break;
    }
}

# Apache

<IfModule mod_rewrite.c>
Options +FollowSymlinks -Multiviews
RewriteEngine on
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php?/$1 [QSA,PT,L]
</IfModule>
```

#### 参考

[参考1](https://blog.csdn.net/weixin_42064343/article/details/103085582)  
[参考2](https://blog.csdn.net/weixin_39994461/article/details/113403797)  
[参考3](https://blog.csdn.net/qq_46110307/article/details/134399884)  








---
layout:     post
title:      SDWebImage
subtitle:   图片类型、防盗链设置等
date:       2019-05-16
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
	- OC
    - SDWebImage
---

#### 类型

`SDWebImage`加载图片`http`请求`header`中设置了`Accept`类型后,当请求的类型与`Accept`类型不匹配时,就会导致`error`,出现请求失败;

解决的办法是:

```
[[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
```

#### 防盗链

图片防盗链主要是`web`端,当然App客户端也可以设置:

```
[[SDWebImageManager sharedManager].imageDownloader setValue: @"value" forHTTPHeaderField:@"referer"];
```

上面的`@value`一般情况下是自己网站的域名,如果不是的话需要和服务端沟通。
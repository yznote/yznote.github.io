---
layout:     post
title:      GoogleAnalyt
subtitle:  	分析统计
date:       2021-06-24 13:55:26 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - 分析
---

![图1](/img/20210624/2.png)
![图1](/img/20210624/1.png)

第一步:填写包名、应用名称;  
第二步:Google自动配置并生成`.plist`文件;  
第三步:下载生成的`GoogleService-Info.plist`并拖入项目中; 
第四步:下载SDK `pod 'Firebase/Analytics'`;  
第五步:在`launchoption`中配置`[FIRApp configure];`;  
第六步:卸载原有应用,并重新运行,Google控制台自动检测配置是否正确;  

地址:[https://analytics.google.com/analytics/web/?authuser=1#/p276130010/realtime/overview?params=_u..nav%3Ddefault](https://analytics.google.com/analytics/web/?authuser=1#/p276130010/realtime/overview?params=_u..nav%3Ddefault)
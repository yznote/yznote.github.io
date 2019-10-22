---
layout:     post
title:      Xcode Tips
subtitle:   警告、log等
date:       2018-08-24
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - Xcode
    - 控制台log
    - xcode10&iOS12
---

#### 去除警告

>另：`inhibit_all_warnings!——pod`中去除警告  

找到下图所示的`Other Warning Flags`，双击，添加`-Wno-deprecated-declarations`就可以了。

![项目1](/img/20180824/1.png)

#### iOS12开发问题 

[链接](https://www.jianshu.com/p/e939e51cc3ad)

#### log

```
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"HH:mm:ss:SSSSSS"]; \
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"\nRK:%s %s %d %s~ \n %s\n\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__func__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
# define NSLog(...)
#endif
```
#### xcode 10 & iOS 12

[链接](https://awhisper.github.io/2018/06/08/libstdc-inxcode10ios12/)



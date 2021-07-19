---
layout:     post
title:      Xcode Tips
subtitle:   警告、log等
date:       2018-08-24 12:11:10 +0800
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

#### Log【补充:2021-7-19】

**自定义Log**

```
#if DEBUG
#import <UIKit/UIKit.h>
#define NSLog(FORMAT, ...) fprintf(stderr,"\n[%s %s:%d行] %s\n",\
[((id(*)(void))method_getImplementation(class_getClassMethod(NSObject.class, @selector(rk_getConsoleLogOfTime))))() UTF8String], \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#import <UIKit/UIKit.h>
#define NSLog(FORMAT, ...) nil

#endif
```
```
#import "NSObject+RKLog.h"

@implementation NSObject (RKLog)

+ (NSString *)rk_getConsoleLogOfTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd hh:mm:ss.SSS"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
```

>注意:  
1.要导入 `#import <UIKit/UIKit.h>` 否则会报错 'Use of undeclared identifier、No known class menthod for selector stringWithUTF8String'等错误;  
2.使用‘NSLog()’的时候会有警告'Undeclared selector rk_getConsoleLogOfTime',那是因为'rk_getConsoleLogOfTime'在‘NSObject’的分类中,解决方案有很多例如:`Targets`->`Build Setting`->'搜索 undeclared selector'将其'value'值设置为`NO`即可;




#### xcode 10 & iOS 12

[链接](https://awhisper.github.io/2018/06/08/libstdc-inxcode10ios12/)



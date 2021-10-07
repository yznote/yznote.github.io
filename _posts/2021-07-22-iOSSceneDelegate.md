---
layout:     post
title:      iOSSceneDelegate
subtitle:  	iOSSceneDelegate
date:       2021-07-22 09:57:30 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - 重置根控制器
---


#### iOS 13 新特性之 `UIWindowScene`
```
-(UIWindow *)getRootWindow {
    if (@available(iOS 13.0,*)) {
        /*
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *window in [windows reverseObjectEnumerator]) {
            if ([window isKindOfClass:[UIWindow class]] &&
                window.windowLevel == UIWindowLevelNormal &&
                CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds) &&
                window.hidden == NO){
                return window;
            }
        }
        */
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                NSLog(@"get==:%@",windowScene.windows);
                for (UIView *view in windowScene.windows) {
                    if ([view isKindOfClass:[UIWindow class]]) {
                        UIWindow *window = (UIWindow *)view;
                        return window;
                    }
                }
            }
        }
        return [UIApplication sharedApplication].delegate.window;
    }else {
        return [UIApplication sharedApplication].delegate.window;
    }
}
```


**拿到`window`就可以按照之前的方法进行重置跟控制器了:**
  
```
 UIWindow *window = [self getRootWindow];
 window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
```







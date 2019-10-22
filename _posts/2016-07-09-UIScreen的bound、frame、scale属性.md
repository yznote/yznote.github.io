---
layout:     post
title:      UIScreen的bound、frame、scale属性
subtitle:   
date:       2016-07-09
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - OC
    - 像素
---

>A UIScreen object contains the bounding rectangle of the device’s entire screen. When setting up your application’s user interface, you should use the properties of this object to get the recommended frame rectangles for your application’s window.  
UIScreen对象包含了整个屏幕的边界矩形。当构造应用的用户界面接口时，你应该使用该对象的属性来获得推荐的矩形大小，用以构造你的程序窗口。

以下列出的属性和操作是我用过的：  
`mainScreen` `Returns the screen object representing the device’s screen.`
`bounds` `property` `Contains the bounding rectangle of the screen, measured in points. (read-only)`
`applicationFrame` `property` `The frame rectangle for the app window. (read-only)`
`scale` `property` `The natural scale factor associated with the screen. (read-only)`
```obj-c
CGRect bound = [[UIScreen mainScreen] bounds];  // 返回的是带有状态栏的Rect  
CGRect frame = [[UIScreen mainScreen] applicationFrame];  // 返回的是不带有状态栏的Rect  
float scale = [[UIScreenmainScreen] scale]; // 得到设备的自然分辨率  
```
对于`scale`属性需要做进一步的说明：  
以前的`iphone` 设备屏幕分辨率都是`320*480`，后来`apple` 在`iPhone 4`中采用了名为`Retina`的显示技术，`iPhone 4`采用了`960x640`像素分辨率的显示屏幕。由于屏幕大小没有变，还是3.5英寸，分辨率的提升将i`Phone 4`的显示分辨率提升至`iPhone 3GS`的四倍，每英寸的面积里有326个像素。  
`scale`属性的值有两个：  
`scale = 1`; 的时候是代表当前设备是`320*480`的分辨率（就是`iphone4`之前的设备）  
`scale = 2`; 的时候是代表分辨率为`640*960`的分辨率  
 
判断屏幕类型：
```obj-c
// 判断屏幕类型，普通还是视网膜  
float scale = [[UIScreen mainScreen] scale];  
if (scale == 1) {  
    bIsRetina = NO;  
    NSLog(@"普通屏幕");  
}else if (scale == 2) {  
    bIsRetina = YES;  
    NSLog(@"视网膜屏幕");  
}else{  
    NSLog(@"unknow screen mode !");  
}  
```
对`dpi`和`ppi`的理解：  
`DPI`是每英寸的点数，可以简单理解为点的密度。  
`PPI`是每英寸的像素数，可以简单理解为像素密度。  
点和像素有区别吗？很多时候，`一个点 ＝ 一个像素`。但是，并不尽然，如`iPhone`的视网膜屏幕，它一个点包含了四个像素，大大提高了显示清晰度。
使用`UIScreen`获取的`bounds`和`frame`，都是点的尺寸，而非像素尺寸。例如，在视网膜屏的`iPhone4`上，我获取的 `applicationFrame`大小是`320x460`，很明显它代表的是点的数量。假如你要显示一张图，如果该图原大小是`100x200`，那么显示在这 样的屏幕上，它的实际显示出来的尺寸将只有原来大小的一半，但它的像素数并未改变。更加需要考虑的是，如果你要对这张图进行缩放，那么缩放率该按照实际显 示尺寸计算，还是按照实际像素数计算？这一块很重要，曾走了不少弯路，答案是前者。















---
layout:     iyznote
title:      uniapp
subtitle:  	uniapp学习笔记
description: 
date:       2020-05-11 20:12:26 +0800
createdate: 2021-09-20 08:00:00 +0800
rkupdate:   2022-08-06 10:30:20 +0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - uniapp
---

### CSS部分

##### 背景图写法

```css
background-image: url('~@/static/images/code-bg.png');
```

##### 底部固定布局、刘海屏适配

```css
position: fixed;
bottom: 98rpx;
bottom: calc(98rpx + constant(safe-area-inset-bottom));
bottom: calc(98rpx + env(safe-area-inset-bottom));
```

##### 返回键
>from 触发返回行为的来源：  
'backbutton': 左上角导航栏按钮及安卓返回键;  
'navigateBack': uni.navigateBack() 方法;  
支付宝小程序端不支持返回此字段.

```js
export default {
    data() {
        return {};
    },
    onBackPress(options) {
        console.log('from:' + options.from)
    }
}
```
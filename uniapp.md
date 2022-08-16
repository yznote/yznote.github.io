---
layout:     iyzpost
title:      uniapp
subtitle:  	uniapp学习笔记
description: 
date:       2020-05-11 20:12:26 +0800
createdate: 2022-08-06 08:00:00 +0800
rkupdate:   2022-08-11 10:30:20 +0800
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

### 获取元素


#### 监听

```js
let active;
document.getElementById("pageIndexs").children.forEach((dom) => {
    dom.addEventListener("click", (e) => {
        /*
         * stopPropagation() 方法防止调用相同事件的传播。
         * 传播意味着向上冒泡到父元素或向下捕获到子元素。
         * https://www.w3school.com.cn/jsref/event_preventdefault.asp
         * https://www.w3school.com.cn/jsref/event_stoppropagation.asp
         */
        e.stopPropagation();
        e.preventDefault();
        if (dom === active) return;
        dom.classList.add("borderShow");
        active && active.classList.remove("borderShow");
        active = dom;
    });
});
```

#### 复用

[用`key`管理可复用的元素](https://v2.cn.vuejs.org/v2/guide/conditional.html#%E7%94%A8-key-%E7%AE%A1%E7%90%86%E5%8F%AF%E5%A4%8D%E7%94%A8%E7%9A%84%E5%85%83%E7%B4%A0)  

```vue
# 会复用
<template v-if="loginType === 'username'">
  <label>Username</label>
  <input placeholder="Enter your username">
</template>
<template v-else>
  <label>Email</label>
  <input placeholder="Enter your email address">
</template>

# 不会复用
<template v-if="loginType === 'username'">
  <label>Username</label>
  <input placeholder="Enter your username" key="username-input">
</template>
<template v-else>
  <label>Email</label>
  <input placeholder="Enter your email address" key="email-input">
</template>
```

#### v-if vs v-show

一般来说,`v-if`有更高的切换开销,而`v-show`有更高的初始渲染开销.因此,如果需要非常频繁地切换,则使用`v-show`较好;如果在运行时条件很少改变,则使用`v-if`较好.


#### v-for
[在`v-for`里使用对象](https://v2.cn.vuejs.org/v2/guide/list.html#%E5%9C%A8-v-for-%E9%87%8C%E4%BD%BF%E7%94%A8%E5%AF%B9%E8%B1%A1)  

```vue

<ul id="v-for-object" class="demo">
              值、键、下标
  <li v-for="(value, name, index) in object">
    {{ value }}
  </li>
</ul>

new Vue({
  el: '#v-for-object',
  data: {
    object: {
      title: 'How to do lists in Vue',
      author: 'Jane Doe',
      publishedAt: '2016-04-10'
    }
  }
})
```





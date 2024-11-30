---
layout:     post
title:      GoogleGTM
subtitle:   GoogleGTM
date:       2024-12-01 10:00:02 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - gtm
---

#### Nuxt2中添加Google-GTM

![示例](/img/20241201/gtm.png)

```js
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-TKSGKJXR');</script>
<!-- End Google Tag Manager -->

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TKSGKJXR"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```

#### 开工

**1.创建analytics.js**

- 放置路径`根目录/static/js/analytics.js`

```js
//
(function(w, d, s, l, i) {
    w[l] = w[l] || [];
    w[l].push({
        'gtm.start': new Date().getTime(),
        event: 'gtm.js'
    });
    var f = d.getElementsByTagName(s)[0],
        j = d.createElement(s),
        dl = l != 'dataLayer' ? '&l=' + l : '';
    j.async = true;
    j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
    f.parentNode.insertBefore(j, f);
})(window, document, 'script', 'dataLayer', 'GTM-TKSGKJXR');

window.dataLayer = window.dataLayer || [];

function gtag() {
    dataLayer.push(arguments);
}
gtag('js', new Date());
gtag('config', 'G-TKSGKJXR');
```

**2.nuxt.config.js**

- 在`head`节点的`script`里添加如下代码:*注意analytics.js*

```js
script: [
    // Google Analytics Code
    {
        src: "https://www.googletagmanager.com/gtag/js?id=GTM-TKSGKJXR",
        async: true,
    },
    // Import analitics.js file
    {
        src: "/pc/js/analytics.js"
    },
],
```

**3.body-noscript**

- 放置位置`根目录/layouts/default.vue`

```js
mounted() {
    /*
    let noscriptDom = document.createElement('noscript')
    noscriptDom.innerHTML = `<iframe
        src="https://www.googletagmanager.com/ns.html?id=GTM-TKSGKJXR"
        height="0"
        width="0"
        style="display:none;visibility:hidden">
        </iframe>`
    document.body.insertBefore(noscriptDom, document.getElementById('__nuxt'))
    */
   let noscriptDom = document.createElement('noscript');
   let iframe = document.createElement('iframe');
   iframe.src = 'https://www.googletagmanager.com/ns.html?id=GTM-TKSGKJXR';
   iframe.height = '0';
   iframe.width = '0';
   iframe.style.display = 'none';
   iframe.style.visibility = 'hidden';
   noscriptDom.appendChild(iframe);
   document.body.insertBefore(noscriptDom, document.getElementById('__nuxt'));
}
```

#### 效果

![示例](/img/20241201/res1.png)
![示例](/img/20241201/res2.png)

#### 检测

![示例](/img/20241201/check.png)

[参考1](https://juejin.cn/post/7395867506027053097)  
[参考2](https://mspase.com/articles/programming/add-google-analytics-nuxt/)  
[参考3-nuxt3?未验证](https://cloud.tencent.com/developer/information/%E5%A6%82%E4%BD%95%E5%9C%A8nuxt.js%E7%BB%84%E4%BB%B6%E4%B8%AD%E6%B7%BB%E5%8A%A0gtm%20dataLayer%EF%BC%9F)  

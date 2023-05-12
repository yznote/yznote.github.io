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

### 自定义返回按钮

```
<!-- 返回键 -->
<view class="nav-box">
    <status-bar></status-bar>
    <view class="navi" style="height: 44px;">
        <view class="back-box">
            <view class="btn-menu">
                <view class='iconfont icon-fenxiang1' @click="clickBack"></view>
                <view class="iconfont icon-home" @click="clickHome"></view>
            </view>
        </view>
        <view class="title-box">
            <view class="title rk-line">房屋详情</view>
        </view>
    </view>
</view>
<view class="nav-space">
    <status-bar></status-bar>
    <view class="navi" style="height: 44px;"></view>
</view>

// js
clickBack(){
    uni.navigateBack();
},
clickHome(){
    uni.reLaunch({
        url:"/pages/index/index",
    })
},

//css
.nav-box{
    background-color: #fff;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    right: 0;
    .navi{
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        .back-box {
            position: absolute;
            left: 16rpx;
            .btn-menu{
                display: flex;
                align-items: center;
                width: 140rpx;
                height: 54rpx;
                background: rgba(0, 0, 0, .25);
                border-radius: 100rpx;
                .iconfont {
                    flex: 1;
                    text-align: center;
                    color: #fff;
                    box-sizing: border-box;
                    &.icon-fenxiang1 {
                        border-right: 1px solid #fff;
                    }
                }
            }
        }
        .title-box{
            max-width: 50%;
            .title{
                width: 100%;
                font-size: 16px;
                font-weight: bold;
            }
        }
    }
}
.nav-space {
    background-color: transparent;
}

```


### 阻止遮罩层滑动事件穿透

```
// template 父视图添加 
@touchmove.stop.prevent="moveStop"
// js method 实现空方法 moveStop 
```

### 数据源更新
>当数据源嵌套有多层的时候,改变最内层的值,页面未刷新,可使用`$set`;如:

```
this.dataList.forEach(item=>{
    if(this.value.includes(item[this.map.value])){
        // item.selected = true;
        this.$set(item,'selected',true)
    }else{
        // item.selected = false;
        this.$set(item,'selected',false)
    }
})
```

### replace()
```js
let previewDes = this.desContent;
this.quickType.forEach(item => {
    console.log("rk===>[foreach]" + item.title);
    let filterStr = item.title+':';
    previewDes = previewDes.replace(RegExp(filterStr, "g"),'');
}); 
previewDes = previewDes.replace(/[\r\n]/g,'');
```


### CSS部分

##### 背景图写法

```css
background-image: url('~@/static/images/code-bg.png');

background:linear-gradient(to bottom, #EA7E00 0%, #E82F00 100%);
```

##### 底部固定布局、刘海屏适配

```css
position: fixed;
bottom: 98rpx;
bottom: calc(98rpx + constant(safe-area-inset-bottom));
bottom: calc(98rpx + env(safe-area-inset-bottom));
```

##### 弹窗
```html
<view class="com-alert-pop">
    <view class="mask" v-if="alertShow"></view>
    <view class="popup-alert" :class="alertShow?'popup-active':''">
        <view class="title">{{alertTitle}}</view>
        <view class="des-box">
            <text class="des">{{alertContent}}</text>
        </view>
        <view class="bot-box">
            <view v-if="showCancel" class="bot-btn cancel" @click="clickCancel" >{{cancelTitle}}</view>
            <view class="bot-btn confirm" @click="clickConfirm">{{confirmTitle}}</view>
        </view>
        
    </view>
</view>
```

```css
.mask {
    position: fixed;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.3);
    z-index: 1000;
}
.popup-alert {
    position: fixed;
    top: 45%;
    left: 50%;
    z-index: 1001;
    width: 544rpx;
    padding-top: 48rpx;
    // padding-bottom: 30rpx;
    border-radius: 24rpx;
    background-color: #ffffff;
    transform: translate(-50%, -50%) scale(0);
    opacity: 0;
    transition: 0.3s;
    line-height: 1;
    text-align: center;
    color: #282828;
    .title {
        max-width: 90%;
        margin-right: auto;
        margin-left: auto;
        font-weight: bold;
        font-size: 32rpx;
    }
    .des-box {
        margin-top: 24rpx;
        padding: 0 30rpx;
        .des {
            font-size: 28rpx;
            color:#323232;
            line-height: 1.1em;
        }
    }
    
    .bot-box {
        display: flex;
        justify-content: space-evenly;
        margin: 30rpx 0 0;
        border-top: 2rpx solid #eee;
        .bot-btn {
            width: 50%;
            padding: 20rpx 50rpx;
            color:#323232;
            // border-radius: 50rpx;
            box-sizing: border-box;
        }
        .cancel {
            // background:#969696;
            border-right: 3rpx solid #eee;
        }
        .confirm {
            color: $main-color;
            // background: linear-gradient(to right, #FE6E21 0%, #FF1F13 100%);
        }
    }
}
.popup-active {
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
}
```

```js
name:'alertPop',
props:{
    alertShow:{
        type:Boolean,
        default:false,
    },
    showCancel:{
        type:Boolean,
        default:true,
    },
    alertTitle:{
        type:String,
        default:'提示',
    },
    alertContent:{
        type:String,
        default:'提示内容',
    },
    cancelTitle:{
        type:String,
        default:'取消',
    },
    confirmTitle:{
        type:String,
        default:'确认',
    }
},

```

##### 弹窗2
```
<template>
    <view class="com-alert-pop">
        <view class="mask" v-if="alertShow"></view>
        <view class="popup-alert" :class="alertShow?'popup-active':''">
            <view class="title">{{alertTitle}}</view>
            <view class="right-top-close" @click="clickClose">
                <uni-icons type="closeempty" color="#969696"></uni-icons>
            </view>
            <view class="des-box">
                <text class="des">{{alertContent}}</text>
            </view>
            <view class="bot-box2">
                <view v-if="showCancel" class="bot-btn cancel" @click="clickCancel">{{cancelTitle}}</view>
                <view class="bot-btn confirm" @click="clickConfirm">{{confirmTitle}}</view>
            </view>

        </view>
    </view>
</template>

<script>
    export default {
        name: 'rk-alert',
        props: {
            alertShow: {
                type: Boolean,
                default: false,
            },
            showCancel: {
                type: Boolean,
                default: true,
            },
            alertTitle: {
                type: String,
                default: '提示',
            },
            alertContent: {
                type: String,
                default: '提示内容',
            },
            cancelTitle: {
                type: String,
                default: '取消',
            },
            confirmTitle: {
                type: String,
                default: '确认',
            }
        },
        methods:{
            clickClose(){
                this.$emit('close')
            },
            clickCancel(){
                this.$emit('cancel')
            },
            clickConfirm(){
                this.$emit('confirm')
            },
        }
    }
</script>

<style lang="scss">
    .mask {
        position: fixed;
        left: 0;
        top: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.3);
        z-index: 1000;
    }

    .popup-alert {
        position: fixed;
        top: 45%;
        left: 50%;
        z-index: 1001;
        width: 544rpx;
        padding-top: 48rpx;
        // padding-bottom: 30rpx;
        border-radius: 24rpx;
        background-color: #ffffff;
        transform: translate(-50%, -50%) scale(0);
        opacity: 0;
        transition: 0.3s;
        line-height: 1;
        text-align: center;
        color: #282828;

        .right-top-close{
            position: absolute;
            right: 0rpx;
            top: 0rpx;
            padding: 20rpx;
        }
        
        .title {
            max-width: 90%;
            margin-right: auto;
            margin-left: auto;
            font-weight: bold;
            font-size: 32rpx;
        }

        .des-box {
            margin-top: 30rpx;
            padding: 0 30rpx;

            .des {
                font-size: 28rpx;
                color: #323232;
                line-height: 1.1em;
            }
        }
        // 样式1
        .bot-box {
            display: flex;
            justify-content: space-evenly;
            margin: 30rpx 0 0;
            border-top: 2rpx solid #eee;
            .bot-btn {
                width: 50%;
                padding: 20rpx 50rpx;
                color: #323232;
                box-sizing: border-box;
            }
            .cancel {
                border-right: 3rpx solid #eee;
            }
            .confirm {
                color: $app-color-main;
            }
        }
        // 样式2
        .bot-box2{
            display: flex;
            justify-content: space-evenly;
            margin: 30rpx 0;
            .bot-btn {
                width: 40%;
                padding: 20rpx 50rpx;
                color: #323232;
                box-sizing: border-box;
                background-color: $app-color-gold;
                border-radius: 10rpx;
                color: #fff;
                font-size: 13px;
            }
            .cancel {
                
            }
            .confirm {
                background-color: #000;
                color: $app-color-gold;
            }
        }
    }

    .popup-active {
        transform: translate(-50%, -50%) scale(1);
        opacity: 1;
    }
</style>

```



##### 动画

```css
.animation-class {
    // 定义动画名称 mymove
    animation: mymove 1s;
    -moz-animation: mymove 1s;
    -webkit-animation: mymove 1s;
    -o-animation: mymove 1s;

    // 执行1次
    animation-iteration-count: 1;
    -moz-animation-iteration-count: 1;
    -webkit-animation-iteration-count: 1;
    -o-animation-iteration-count: 1;

    // 执行完毕停留在动画结束的最后一帧
    animation-fill-mode: forwards;
    -moz-animation-fill-mode: forwards;
    -webkit-animation-fill-mode: forwards;
    -o-animation-fill-mode: forwards;
}

@keyframes mymove {
    0% {
        transform: translate(-100%);
    }
    100% {
        transform: translate(0);
    }
}

```

##### 单行、多行文本
```css
display: -webkit-box;
overflow: hidden;
text-overflow: ellipsis;
word-wrap: break-word;
white-space: normal !important;
-webkit-box-orient: vertical;
-webkit-line-clamp: 1;
```


#### scroll-view的横向滚动

```
<scroll-view :scroll-x="true" class="scrollCon">
    <view class="monthItem">1月</view>
    <view class="monthItem">2月</view>
    <view class="monthItem">3月</view>
    <view class="monthItem">4月</view>
    <view class="monthItem">5月</view>
    <view class="monthItem">6月</view>
    <view class="monthItem">7月</view>
    <view class="monthItem">8月</view>
    <view class="monthItem">9月</view>
    <view class="monthItem">10月</view>
    <view class="monthItem">11月</view>
    <view class="monthItem">12月</view>
</scroll-view>
```
**CSS部分**
```
.scrollCon{
    white-space: nowrap;
    display: flex;
    align-items: center;
}
    
.monthItem{
    display: inline-block;
    width: calc(100% / 6);
    font-size: 26rpx;
    color: #3D3D3D;
    text-align: center;
}
```
**核心**
```
// scroll-view的外层元素需要
white-space: nowrap;

// scroll-view的内层view元素需要
display: inline-block;
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

#### 小程序定位权限

>chooseLocation:fail the api need to be declared in the requiredPrivateInfos field in app.json/ext.json错误的解决办法  

解决方案`源码视图`-`"mp-weixin"`节点,添加`requiredPrivateInfos` 如下：

```
"mp-weixin" : {
        "appid" : "wxec7ecf3d44019688",
        "setting" : {
            "urlCheck" : false,
            "es6" : false
        },
        "usingComponents" : true,
        "betterScopedSlots" : true,
        "permission" : {
            "scope.userLocation" : {
                "desc" : "演示在onShow生命周期获取地理位置"
            }
        },
    "requiredPrivateInfos" : [ "chooseLocation", "getLocation" ]
    },
```

#### H5定位权限

h5节点`"h5"`内添加:  
```
"sdkConfigs": {
    // 使用地图或位置相关功能必须填写其一
    "maps": {
            "qqmap": {
                // 腾讯地图秘钥 https://lbs.qq.com/dev/console/key/manage
                "key": ""
            },
            "google": {
                // 谷歌地图秘钥（HBuilderX 3.2.10+）https://developers.google.com/maps/documentation/javascript/get-api-key
                "key": ""
            },
            "amap": {
                // 高德地图秘钥（HBuilderX 3.6.0+）https://console.amap.com/dev/key/app
                "key": "a88713f7236ab59b9a3a537544b6c9bb",
                // 高德地图安全密钥（HBuilderX 3.6.0+）https://console.amap.com/dev/key/app
                "securityJsCode": "b5254b0eb737c762b70b83461e2194d8",
                // 高德地图安全密钥代理服务器地址（HBuilderX 3.6.0+）https://lbs.amap.com/api/jsapi-v2/guide/abc/prepare
                "serviceHost": "https://api.bspapp.com"
            }
    }
}
```

#### Uniapp-微信小程序设置打包忽略文件

设置方法`源码视图`-`"mp-weixin"`节点,添加`packOptions` 如下：

```
{
  "packOptions": {
    "ignore": [{
      "type": "file",
      "value": "test/test.js"
    }, {
      "type": "folder",
      "value": "test"
    }, {
      "type": "suffix",
      "value": ".webp"
    }, {
      "type": "prefix",
      "value": "test-"
    }, {
      "type": "glob",
      "value": "test/**/*.js"
    }, {
      "type": "regexp",
      "value": "\\.jsx$"
    }]
  }
}
```
>其中，type 可以取的值为 folder、file、suffix、prefix、regexp2、glob2，分别对应文件夹、文件、后缀、前缀、正则表达式、Glob 规则。所有规则值都会自动忽略大小写。  
注 1: value 字段的值若表示文件或文件夹路径，以小程序目录 (miniprogramRoot) 为根目录。  
注 2: regexp、glob 仅 1.02.1809260 及以上版本工具支持。

[微信文档](https://developers.weixin.qq.com/miniprogram/dev/devtools/projectconfig.html)


#### uniCloud项目配置

【App报错】`Client platform is app, but app-plus was found in config.`  
【解决】  
【配置路径】`uni-id的云端配置文件在uniCloud/cloudfunctions/common/uni-config-center/uni-id/config.json中`  

旧项目建议将所有platform为app的场景统一为app-plus，即建议使用如下配置
```
// 以下仅列出相关配置
{
    "preferedAppPlatform": "app-plus", // uni-id内部会将收到的app平台全部转化为app-plus平台
    "app-plus": { // 配置内的平台名称和preferedAppPlatform保持一致
        "oauth": {}
    }
}
```

新项目建议将platform统一为app，即建议使用如下配置
```
// 以下仅列出相关配置
{
    "preferedAppPlatform": "app", // uni-id内部会将收到的app-plus平台全部转化为app平台
    "app": { // 配置内的平台名称和preferedAppPlatform保持一致
        "oauth": {}
    }
}
```

#### uniapp文件引用

**script**  
```
import "./static/yzb-icon.css";
```
**style**  
```
@import './static/yzb-icon.css';
```

#### uniapp应用template中点语法取值问题

1.当返回数据嵌套了三层甚至四层的时候`template`中如果使用`item.one.two.three.content`可能会出问题;  
2.需要格式化(如：日期);  
这时候可以采用以下形式    

**template中**
```vue
<template>
    <text class="text-color-grey">{ formatDates(item.start_date) }-{ formatDates(item.end_date) }</text>
</template>
```
**script中**
```js
export default {
    methods: {
        formatDates(time) {
            if (time == null || time === '') {
                return 'N/A';
            }
            let date = new Date(time);
            // return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
            return formatDate(date, 'yyyy.MM');
        },
    }
}
```













---
layout:     post
title:      CocoaPods
subtitle:   解决cocoapods安装完成后不能 pod search的问题
date:       2016-10-13 22:30:06 +0800
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - OC
---

#### CocoaPods是什么？

`CocoaPods`是一个负责管理`iOS`项目中第三方开源库的工具。`CocoaPods`的项目源码在`Github`上管理。该项目开始于2011年8月12日，在这两年多的时间里，它持续保持活跃更新。开发`iOS`项目不可避免地要使用第三方开源库，`CocoaPods`的出现使得我们可以节省设置和更新第三方开源库的时间，在`iOS`开发中经常会用到第三方库如`AFNetworking`,`ASIHttpRequest`等，在使用第三方库时，你除了要导数源码外，但是，集成这些依赖库需要我们手动去配置，还有当这些第三方库发生了更新，还需要手动去更新项目。这就显得非常麻烦。有麻烦自然有解决办法，`CocoaPods`就是为了解决这个问题而生的。通过`CocoaPods`，我们可以将第三方的依赖库统一管理起来，配置和更新只需要通过简单的几行命令即可完成。

#### CocoaPods的下载及安装

`mac`系统已经默认安装好`Ruby`环境，如果你不确定自己系统中是否有`Ruby`的，可以在终端中输入命令行：`ruby -v`查看当前`ruby`版本.

确定以后，接下来就可以下载和安装`CocoaPods`，只需要一行命令。在`Terminator`（也就是终端）中输入以下命令：

```
sudo gem install cocoapods
```

但是，在终端中敲入这个命令之后，会发现半天没有任何反应。原因是那堵墙阻挡了`cocoapods.org`。  
解决办法是，我们可以用阿里云的`Ruby`镜像来访问`cocoapods`。按照下面的顺序在终端中敲入依次敲入命令：  
首先，检查你的`ruby`源：  
```
gem sources -l
```
默认情况下，终端应该返回如下信息：

```
*** CURRENT SOURCES ***
https://rubygems.org/
```

当然这个源在墙内是访问不到的。因此我们需要寻找一个可以在国内访问到的镜像。目前笔者找到的是[这个](http://rubygems-china.oss.aliyuncs.com)这个阿里云的镜像，当然随着时间的推移，未来这个镜像也有可能无法访问了，到时候就只能重新寻找了。确认镜像可用后，现在就要开始修改`ruby`源了。首先执行以下命令删除原来的`ruby`源  
```
gem sources --remove https://rubygems.org/
```
执行命令后可在终端看见以下信息：  

```
https://rubygems.org/ removed from sources
```
然后下一步添加你找到的可用的镜像源：
```
gem sources -a http://rubygems-china.oss.aliyuncs.com
```
此时如果你再执行
```
gem sources -l
````
就能看到当前镜像源里只有阿里云这一个了。此时你就可以重新执行这一段开头的那句命令了：
```
sudo gem install cocoapods
```
如果一切正常，你应该能看到一段安装进度，以及最后有一条信息：
```
gems installed
```
确认看见这条信息，后先判断的`CocoaPods`是否可以使用，可以用`CocoaPods`的搜索功能验证一下。在终端中输入：
```
pod search AFNetworking；
```

执行后可能会一直停在
```
Setting up CocoaPods master repo
```
然后(很久)会出现如下错误：

![腾讯博客原图片丢失了](/img/noimg.jpeg)

解决办法是：

这说明`CocoaPods`还不能正常使用，需要更新`pod`，下载它的一些依赖包；在终端中输入：
```
pod setup
```
过一段时间之后，你会在终端中看到跟上面同样的红色的错误信息。

这说明某些环境原因导致`pod`更新不了，可能原因有:  
>1.gem版本太低；  
2.github无法链接；  
3..cocoapods目录下的配置信息错误。  

我们可以一个一个来排除，

首先更新`gem`到最新版本，在终端中输入：  
```
sudo gem update --system
``` 
然后检查是否可以`ping`通`github`，在终端中输入：

```
ping github.com 
```
然后查看`pob repo list`：

```
pod repo list
```
说明`Cocoapods`在将它的信息下载到` ~/.cocoapods`里；

`cd` 到该目录里，用`du -sh *`命令来查看文件大小，结果显示`0 repos`，说明没有安装成功；

在终端输入：
```
cd ~/.cocoapods
```
进入`cocoapods`文件后在终端输入：`du -sh *`

重新执行`pod setup`，过一段时间后提示`setup completed`,在终端中输入 `pod list`，展示出安装列表；

这样总算安装好了。接下来再一次输入：
```
pod search AFNetworking
```
输入过后它可能会报：
```
[!] Unable to find a pod with name, author, summary, or descriptionmatching `AFNetworking`
```
解决方案是：输入：

```
rm ~/Library/Caches/CocoaPods/search_index.json
```
后在一次输入：`pod search AFNetworking`

就可以咯。

#### cocoapods的使用

首先来到你的项目文件：

cd 项目文件的位置  
然后，添加一个`Podfile`文件： `vim Podfile`  
然后按i进入插入模式，进行编辑，在文件中输入以下内容：  
注意百度上很多旧版本输入的类容：  
```
platform :ios, '8.1'
pod 'AFNetworking', '~> 2.0'
```

它会报：
```
[!] The dependency `AFNetworking (~> 3.0)` is not used in any concrete target.
```

现在版本升级官方给的文档是：
```
platform :ios, '8.0'

target '你的项目名称' do

pod 'AFNetworking', '~> 3.0'

end
```

注意：`你的项目名称`是你项目文件中`xx.xcodeproj`文件，`xx.xcodeproj`去掉后缀名所得的`xx`==（就是）`你的项目名称`

输入完成后按`ESC`退出编辑模式，最后输入`:wq`保存并退出文件。此时可以发现在项目目录下多了一个`Podfile`的文件，请注意这个文件必须与`.xcodeproj`在同一目录下。

最后：
```
pod install
```
没报错就可以了。


#### 最后

**2017-03-06 补充** [参考](http://code4app.com/article/cocoapods-install-usage)

**2017-03-06 补充** [Podfile 格式](http://www.jianshu.com/p/28a7e98c09a2)










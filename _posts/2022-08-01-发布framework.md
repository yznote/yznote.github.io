---
layout:     post
title:      发布framework
subtitle:  	制作自定义framework、模块化
date:       2022-08-01 12:00:20 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - Pod
---


#### 准备
1.制作`framework`移步[这里](https://yuan920.github.io/2020/02/15/iOS%E9%9D%99%E6%80%81%E5%BA%93%E5%92%8C%E5%8A%A8%E6%80%81%E5%BA%93%E7%9A%84%E5%88%9B%E5%BB%BA%E5%92%8C%E4%BD%BF%E7%94%A8/);  
2.首次上传需要创建`Trunk`账号;  
```
# 创建
pod trunk register 邮箱 '用户名' --verbose 

# 检测
pod trunk me
```

#### 上传

1.创建一个`PodLib`模板
```
pod lib create RKKeepAlive
```
2.根据提示完成项目配置
```
Cloning `https://github.com/CocoaPods/pod-template.git` into `RKKeepAlive`.
Configuring RKKeepAlive template.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.

------------------------------

To get you started we need to ask a few questions, this should only take a minute.

If this is your first time we recommend running through with the guide: 
 - https://guides.cocoapods.org/making/using-pod-lib-create.html
 ( hold cmd and double click links to open in a browser. )


What platform do you want to use?? [ iOS / macOS ]
 > ios

What language do you want to use?? [ Swift / ObjC ]
 > objc

Would you like to include a demo application with your library? [ Yes / No ]
 > yes

Which testing frameworks will you use? [ Specta / Kiwi / None ]
 > none

Would you like to do view based testing? [ Yes / No ]
 > no

What is your class prefix?
 > RK
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.

Running pod install on your new library.

Analyzing dependencies
Downloading dependencies
Installing RKKeepAlive (0.1.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `RKKeepAlive.xcworkspace` for this project from now on.
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.

[!] Your project does not explicitly specify the CocoaPods master specs repo. Since CDN is now used as the default, you may safely remove it from your repos directory via `pod repo remove master`. To suppress this warning please add `warn_for_unused_master_specs_repo => false` to your Podfile.

 Ace! you're ready to go!
 We will start you off by opening your project in Xcode
  open 'RKKeepAlive/Example/RKKeepAlive.xcworkspace'

To learn more about the template see `https://github.com/CocoaPods/pod-template.git`.
To learn more about creating a new pod, see `https://guides.cocoapods.org/making/making-a-cocoapod`.
```
3.在`GitHub`创建一个仓库,并将刚创建的项目`RKKeepAlive`关联远程仓库;  
4.在`RKKeepAlive/RKKeepAlive`目录下创建`frameworks`文件夹`【和Assets、Classes同级】`并将准备工作中制作完成的`framework`放到此目录下; 
5.编辑`.podspec`,配置`framework`路径
```
s.vendored_frameworks = 'RKKeepAlive/Frameworks/RKKeepAlive.framework'
``` 
6.校验
```
# 本地校验
pod lib lint 

# 远程校验
pod spec lint 
```
7.可能出现的问题
```
Q:1>
[!]  RKKeepAlive did not pass validation, due to 1 warning (but you can use `--allow-warnings` to ignore it).
You can use the `--no-clean` option to inspect any issue.
A:添加  --allow-warnings  --no-clean 即可
pod lib lint --allow-warnings  --no-clean
pod spec lint --allow-warnings  --no-clean


Q:2>
- ERROR | [iOS] xcodebuild: Returned an unsuccessful exit code.
A:在.podspec添加 
s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
```
8.通过验证后将代码提交`git`远程仓库，并添加`tag`
```
# 版本号要和.podspec中版本一致
git tag 0.1.0
#推送远端
git push --tags
```
9.上传
```
pod trunk push
```
出现如下提示说明成功
```
Validating podspec
 -> RKKeepAlive (0.1.0)
    - NOTE  | xcodebuild:  note: Using new build system
    - NOTE  | xcodebuild:  note: Using codesigning identity override: -
    - NOTE  | xcodebuild:  note: Build preparation complete
    - NOTE  | [iOS] xcodebuild:  note: Planning
    - NOTE  | [iOS] xcodebuild:  note: Building targets in dependency order

Updating spec repo `trunk`

CocoaPods 1.11.3 is available.
To update use: `sudo gem install cocoapods`

For more information, see https://blog.cocoapods.org and the CHANGELOG for this version at https://github.com/CocoaPods/CocoaPods/releases/tag/1.11.3


--------------------------------------------------------------------------------
 🎉  Congrats

 🚀  RKKeepAlive (0.1.0) successfully published
 📅  July 22nd, 03:31
 🌎  https://cocoapods.org/pods/RKKeepAlive
 👍  Tell your friends!
--------------------------------------------------------------------------------
```

#### 使用

1.上传成功后`search`找不到自己上传的`framework`需要执行
```
pod repo update --verbose
```
2.删除
```
pod trunk delete RKKeepAlive 0.1.0
```
#### 其他错误
`'Pods-App' target has transitive dependencies that include static binaries`  
这个错误的意思是，你在做私有组件时使用了第三的静态库。加上`--use-libraries`即可解决  

```
pod lib lint --use-libraries
```

#### 参考资料

[西门桃桃](https://devfutao.com/archives/175/)  
[InfoQ](https://xie.infoq.cn/article/dbfbe3aa0ffdc81a648e7da75)  
[這Er-不支持模拟器只能真机](https://www.jianshu.com/p/88180b4d2ab7/)  
[shenshizhong-git tag 删除](https://www.jianshu.com/p/208aff2dccdc)  





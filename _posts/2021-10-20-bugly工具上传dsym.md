---
layout:     post
title:      bugly工具上传dsym
subtitle:  	bugly工具上传dsym
date:       2021-10-20 10:20:30 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - bugly
---


#### 检查本地`java`版本

命令行输入:
```
java -version
```
显示下列信息说明`JDK`安装成功
>控制台信息:  
```
java version "1.8.0_301"  
Java(TM) SE Runtime Environment (build 1.8.0_301-b09)  
Java HotSpot(TM) 64-Bit Server VM (build 25.301-b09, mixed mode)  
```
  
>**注意:**  
```
1.bugly工具上传只能使用`jdk 1.8.0`,其他版本的会报`尝试打开文件buglyqq-upload-symbol.jar时出现意外错误`  
2.移除java其他版本:`/Library/Java/JavaVirtualMachines/`手动删除即可
```

#### 下载`bugly`工具包

[符号表工具下载](https://bugly.qq.com/v2/downloads)

#### 整理文件  

1.在桌面创建文件夹`DSYM`【文件名随意】  
2.将上一步下载的工具包`buglyqq-upload-symbol.jar`放入创建的文件夹  
3.将`Xcode`生成的`dSYM`文件放入创建的文件夹  
注意:`dSYM`和`buglyqq-upload-symbol.jar`工具包必须在同一个文件

#### 配置信息,开始上传

```
java -jar buglyqq-upload-symbol.jar -appid xxxx -appkey xxxx-xxxx-4xxxx-xxxx-xxxxx -bundleid com.xxxxx.xxxx -version 21.10.19.1 -platform IOS -inputSymbol /Users/yb007/Desktop/DSYM/yblove211019-1.dSYM
```

**参数说明:**  
>参数说明 -- `Introduction for arguments`    
```
 -appid APP ID of Bugly
 -appkey APP Key of Bugly
 -bundleid Android平台对应的是package name/iOS平台是Bundle Id
 -version APP版本，需要和bugly平台上面看到的crash版本号保持对齐
 -platform 平台类型包含三个选项 Android、IOS两个选项，注意大小写要正确
 -inputSymbol 原始符号表[ios是dsym/android平台是debug so]所在文件夹目录地址
 -inputMapping mapping所在文件夹目录地址[Android平台特有，ios忽略]
```

#### 控制台输出以下信息代表`成功`

```
...
##[info]retCode: 200 response message: {"statusCode":0,"msg":"success","uploadReqID":"xxxxxxx"}
##[info]now begin to uploadFileContent
##[info]request uploadFileurl is https://symbol-v2.bugly.qq.com/trpc.eff_tool.symbol_upload_gateway.SymbolUploadGateway/uploadFile
##[info]retCode: 200 response message: {"statusCode":0,"msg":"success","uploadReqID":"xxxxxxx"}

```

#### 生成本地的文件

上传完毕后本地的`DSYM`文件夹会生成以下文件【可以自行删除】
```
 cp_buglyQqUploadSymbolLib.jar
 cp_buglySymboliOS.jar
 buglybin
 xxxx.dSYM.zip
```

























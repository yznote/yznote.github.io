---
layout:     post
title:      objectForKey和valueForKey的区别
subtitle:  	objectForKey和valueForKey的区别
date:       2022-09-07 15:00:16 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - iOS
---


#### objectForKey和valueForKey的区别


##### objectForKey是NSDictionary的方法
objectForKey: returns the value associated with aKey, or nil if no value is associated with aKey. 返回指定`key`的`value`,若没有这个`key`返回`nil`.

##### valueForKey是KVC提供的方法
valueForKey: returns the value associated with a given key. 同样是返回指定`key`的`value`.

但官方文档里有额外一点：一般来说`key`可以是任意字符串组合,如果`key`不是以`@`符号开头,这时候`valueForKey:`等同于`objectForKey:`,如果是以`@` 开头,`valueForKey`方法执行时会去掉`key`里的`@`然后用剩下部分作为`key`执行`[super valueForKey:]`.

在`KVC`里可以通过`property`同名字符串来获取对应的值。找不到值的时候执行`valueForUndefinedKey:`而`valueForUndefinedKey`的默认实现是抛出 `NSUndefinedKeyException`异常.

举例：
```
NSDictionary *dic = [NSDictionary dictionaryWithObject:@"Value" forKey:@"@Key"];// 注意这个 key 是以 @ 开头
NSString *value1 = [dic objectForKey:@"@Key"];
NSString *value2 = [dic valueForKey:@"@Key"];
```
`value1`可以正确取值,但是`value2`取值会直接`crash`！
因此，我们在平时使用`NSDictionary`的时候建议使用`objectForKey`！

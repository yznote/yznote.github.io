---
layout:     post
title:      TextField输入限制
subtitle:   输入限制
date:       2018-09-18 16:21:56 +0800
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - 正则
    - textfield
    - 输入限制
---

#### 正字匹配输入限制

```obj-c
//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _goodPriceTF) {
        //新输入的
        if (string.length == 0) {
            return YES;
        }
        
        //第一个参数，被替换字符串的range
        //第二个参数，即将键入或者粘贴的string
        //返回的是改变过后的新str，即textfield的新的文本内容
        NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *regex;
        if (textField == _goodPriceTF) {
            //正则表达式（只支持两位小数）
            regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
        }else{
            //只能输入非零的正整数( 包含0 @"^[1-9]\\d*|0$")
            regex = @"^[1-9]\\d*$";
            
        }
        //判断新的文本内容是否符合要求
        return [self isValid:checkStr withRegex:regex];
    }
    return YES;
}
//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex {
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}
```
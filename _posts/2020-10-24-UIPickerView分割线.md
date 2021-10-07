---
layout:     post
title:      UIPickerView分割线
subtitle:  	iOS14背景色变为块状
date:       2020-10-24 20:10:24 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - UIPickerView
---

#### iOS14的分割线变成了块状样式

```
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	//去除系统的分割线，添加自定义线条
    for(UIView *speartorView in pickerView.subviews) {
        speartorView.backgroundColor = UIColor.clearColor;
        if (speartorView.frame.size.height < 80) {//找出当前的 View
            // 添加分割线 (判断只添加一次  滑动不断刷新)
            if (speartorView.subviews.count == 0){
                UIView *line = [self lineView];
                line.frame = CGRectMake(0, 0, speartorView.mj_w, 0.5);
                [speartorView addSubview:line];
                UIView *line2 = [self lineView];
                line2.frame = CGRectMake(0, speartorView.mj_h-1, speartorView.mj_w, 0.5);
                [speartorView addSubview:line2];
            }
            speartorView.backgroundColor = [UIColor clearColor];
        }else{
            speartorView.backgroundColor = [UIColor clearColor];
        }
    }
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 40)];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.text = minstr([[priceArray objectAtIndex: row] valueForKey:@"coin"]);
    myView.font = [UIFont systemFontOfSize:16];
    myView.backgroundColor = [UIColor clearColor];
    //[[YBToolClass sharedInstance] lineViewWithFrame:CGRectMake(0, 39, 80, 1) andColor:RGB_COLOR(@"#DCDCDC", 1) andView:myView];
    return myView;
}
- (UIView *)lineView {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, coinPicker.width*0.8, 0.5)];
    line.backgroundColor = RGB_COLOR(@"#DCDCDC", 1);
    return line;
}
```
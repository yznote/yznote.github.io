---
layout:     post
title:      TableView长按与点击
subtitle:  	TableView长按与点击
date:       2020-09-16 10:02:36 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - 手势
---



#### 场景+需求

>场景:评论视图包含主评论(mainTableView)和子评论(subTableView);
>需求:长按主评论或者子评论进行内容复制,同时主、子评论的cell的点击事件不能被拦截


#### 实现

**主评论(mainTableView)**

```
UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
          initWithTarget:self action:@selector(longPressGestureRecognized:)];
[_mainTableview addGestureRecognizer:longPress];


-(void)longPressGestureRecognized:(UILongPressGestureRecognizer*)longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
    	//手势开始
        CGPoint point = [longPressGesture locationInView:_mainTableview];
        //可以获取我们在哪个cell上长按
        NSIndexPath *currentIndexPath = [_mainTableview indexPathForRowAtPoint:point]; 
        NSLog(@"comment0====%@",currentIndexPath);
    }
    if (longPressGesture.state == UIGestureRecognizerStateEnded) {
    	//手势结束
       CGPoint point = [longPressGesture locationInView:_mainTableview];
       //可以获取我们在哪个cell上长按
       NSIndexPath *currentIndexPath = [_mainTableview indexPathForRowAtPoint:point]; 
       NSLog(@"comment1====%@",currentIndexPath);
    } 
}

```


**子评论(subTableView)**

```
UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
      initWithTarget:self action:@selector(longPressGestureRecognized:)];
[_subTableView addGestureRecognizer:longPress];

-(void)longPressGestureRecognized:(UILongPressGestureRecognizer*)longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
    	//手势开始
        CGPoint point = [longPressGesture locationInView:_subTableView];
        //可以获取我们在哪个cell上长按
        NSIndexPath *currentIndexPath = [_subTableView indexPathForRowAtPoint:point]; 
        NSLog(@"detail0====%@",currentIndexPath);
    }
    if (longPressGesture.state == UIGestureRecognizerStateEnded) {
    	//手势结束
       CGPoint point = [longPressGesture locationInView:_subTableView];
       // 可以获取我们在哪个cell上长按
       NSIndexPath *currentIndexPath = [_subTableView indexPathForRowAtPoint:point]; 
       NSLog(@"detail1====%@",currentIndexPath);
    }
}

```

#### 总结

`不能将手势添加到Cell上，因为父类、与子类同时存在手势的时候只有父类响应,另外tableView的didsel方法也会失去响应`












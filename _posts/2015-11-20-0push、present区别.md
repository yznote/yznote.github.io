---
layout:     post
title:      push、present区别
subtitle:   
date:       2015-11-20
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - iOS
    - OC
    - C
---
#### 场景
1. 用`UINavigationController`的时候用`pushViewController:animated`  
>返回之前的视图`[[self navigationController] popViewControllerAnimated:YES];`
>ps：`push`以后会在`navigation`的`left``bar`自动添加`back`按钮，它的响应方法就是返回。所以一般不需要写返回方法，点`back`按钮即可。  
2. 其他时候用`presentModalViewController:animated`
```obj-c
 [self presentModalViewController:controller animated:YES];//YES有动画效果
 ``` 
>返回之前的视图`[self dismissModalViewControllerAnimated:YES];` 
3. 切换视图一般用不到`addSubview`
`UINavigationController`是导航控制器，如果`pushViewController`的话，会跳转到下一个`ViewController`，点返回会回到现在这个`ViewController`；
如果是`addSubview`的话，其实还是对当前的`ViewController`操作，只是在当前视图上面又“盖”住了一层视图，其实原来的画面在下面呢，看不到而已。（当然，也可以用`insertSubView:atIndex:`那个方法设置放置的层次)。  
> **另加一个**  
> 使用presentModalViewControllerAnimated方法从A->B->C，若想在C中直接返回A，则可这样实现：

#### C中返回事件：
```c
void back  
{  
      [self dismissModalViewControllerAnimated:NO];//注意一定是NO！！  
      [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];  
}
```
**然后在B中**  
```c
//在viewdidload中：  
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];  
  
-(void)back  
{  
     [self dismissModalViewControllerAnimated:YES];  
} 
``` 
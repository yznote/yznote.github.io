---
layout:     post
title:      iOS键盘和UIMenuController并存
subtitle:  	iOS键盘和UIMenuController并存
date:       2020-11-02 22:16:12 GMT+0800
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - 键盘和菜单
---

#### 描述以`UITextView`为例
当`UITextView`处于编辑状态时,即键盘存在时,`UITextView`是第一响应者,而当需要弹出`UIMenuController`时,第一响应者需要变更为处理`UIMenuController`菜单事件的对象,此时UITextView就不是第一响应者,键盘就会隐藏,造成键盘和`UIMenuController`不能同时出现.

#### 解决方案
>通过改变响应链来解决:  
>**参考**  
>[iOS事件响应机制](https://www.jianshu.com/p/2e074db792ba)  
>[iOS响应链全家桶](https://www.jianshu.com/p/c294d1bd963d)  
>在保证`UITextVie`第一响应者的前提下,我们可以覆盖改变`UITextView`的`nextResponder`,让`nextResponder`指向`UIMenuController`菜单事件的执行者,同时也要注意,在`UIMenuController`隐藏后,要取消`nextResponder`指向,不改变原有的响应链.

#### 代码实现

**自定义`MYTextView`**
```
@interface MYTextView : UITextView
//覆盖下一个响应者
@property (nonatomic, weak) UIResponder *overrideNextResponder; 
@end
@implementation MYTextView
- (UIResponder *)nextResponder {
    if(_overrideNextResponder == nil){
        return [super nextResponder];
    } else {
        return _overrideNextResponder;
    }
}
//UIMenuController 菜单可以执行操作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
@end
```

**长按显示`UIMenuController`的`VC`**  
这里以长按`VC`中的`self.titleLabel`为例:

```
//长按显示菜单 UIMenuController
- (void)longPressShowMenuView:(UILongPressGestureRecognizer *)longPress {
    //避免长按多次执行
    if (longPress.state != UIGestureRecognizerStateBegan) {
        return;
    }
    //编辑过程中，self.textView是第一响应者
    if(self.textView.isFirstResponder){
        //如果textView是第一响应者，则对titleLabel进行响应链透传，覆盖self.textView的下一个响应者
        self.textView.overrideNextResponder = self.titleLabel;
        //添加菜单隐藏的监听，当菜单隐藏时，要重置self.textView.overrideNextResponder = nil
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuViewDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
    }else {
        //如果当前无第一响应者，就成为第一响应者
        [self.titleLabel becomeFirstResponder];
    }
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *saveItems = [[UIMenuItem alloc] initWithTitle:@"保存" action:@selector(save:)];
    UIMenuItem *noteItem = [[UIMenuItem alloc] initWithTitle:@"笔记" action:@selector(note:)];
    menuController.menuItems = @[noteItem, saveItems];
    if (@available(iOS 13.0, *)) {
        [menuController showMenuFromView:self.view rect:self.titleLabel.frame];
    } else {
        [menuController setTargetRect:self.titleLabel.frame inView:self.view];
        [menuController setMenuVisible:YES animated:YES];
    }
}
//隐藏菜单UIMenuController的通知
- (void)menuViewDidHide:(NSNotification*)notification {
    //重置，不影响原有的响应链
    self.textView.overrideNextResponder = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerDidHideMenuNotification object:nil];
}
```




















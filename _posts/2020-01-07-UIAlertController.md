---
layout:     post
title:      UIAlertController
subtitle:   更改颜色、字体
date:       2020-01-07 17:13:22 +0800
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - AlertController
---

#### AlertController
**iOS8以后系统的提示框改为了UIAlertController,下面利用KVC来更改标题、提示的字体以及颜色**

![项目1](/img/20200107/1.png)

```
NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc]initWithString:@"标题1" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
NSMutableAttributedString *attMessage = [[NSMutableAttributedString alloc]initWithString:@"message" attributes:@{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];

UIAlertController *action = [UIAlertController alertControllerWithTitle:@"标题1" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
[action setValue:attTitle forKey:@"attributedTitle"];
[action setValue:attMessage forKey:@"attributedMessage"];

UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self loadCameraMovie];
}];
[alert1 setValue:[UIColor greenColor] forKey:@"titleTextColor"];
[action addAction:alert1];

UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self loadCamera];
}];
[alert2 setValue:[UIColor cyanColor] forKey:@"titleTextColor"];
[action addAction:alert2];

UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"从相册选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self loadPhotoLibraryMovie];
}];
[alert3 setValue:[UIColor orangeColor] forKey:@"titleTextColor"];
[action addAction:alert3];

UIAlertAction *alert4 = [UIAlertAction actionWithTitle:@"从相册选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self loadPhotoLibraryPhoto];
}];
[alert4 setValue:[UIColor brownColor] forKey:@"titleTextColor"];
[action addAction:alert4];

UIAlertAction *alert5 = [UIAlertAction actionWithTitle:@"从相册选择多张照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self loadQBImagePickerController];
}];
[alert5 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
[action addAction:alert5];

UIAlertAction *can = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
}];
[can setValue:[UIColor redColor] forKey:@"titleTextColor"];
[action addAction:can];
[self presentViewController:action animated:YES completion:nil];
```

#### 使用`runtime`来获取系统属性`key`

```
unsigned int count = 0;
Ivar *ivars = class_copyIvarList(NSClassFromString(@"CYObject"), &count);
//ivars不是数组而是内存地址
NSLog(@"count:%d",count);
for (int i = 0; i < count; i++) {
    //获取成员变量
    Ivar ivar = ivars[i];
    const char *name = ivar_getName(ivar);
    NSString *sname = [NSString stringWithUTF8String:name];
    NSLog(@"name:%@",sname);
}
free(ivars);
```











---
layout:     post
title:      OC-Swift混编与flex布局
subtitle:   OC-Swift混编与flex布局
date:       2024-11-10 10:10:10 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - Swift
    - OC
    - flex
---

### 混编 

**在`objective-c`项目中使用`swift`** 

- TARGETS->Build Setting->输入packaging;  
![示例1](/img/20241114/1.png)  
- 创建Swift文件,这时候工程会提示是否创建桥接文件,选择创建,如果没有提示说明之前使用过桥接文件,还有一种情况是之前使用过,但是后来删除了,参考如下,将旧的路径清空,重新创建即可;  
![示例2](/img/20241114/2.png)  
- 在swif文件中如果要使用oc中的类需要在`YBHiMo-Bridging-Header`暴露;  
```
#import "GHPwdInput.h"
#import "YBProjectMacro.h"
```
- 在oc中使用swift文件`#import "YBHiMo-Swift.h"`;  


### Flex布局

##### 文档与示例
[Api文档](https://layoutbox.github.io/FlexLayout/1.1/Classes/Flex.html)  
[Demo](https://github.com/layoutBox/FlexLayout/blob/master/docs_markdown/examples.md)  

##### 应用
> 由于`FlexLayout`只能在`swfit`中使用,所以要使用`flex`布局要采用`混编`方式.

![示例3](/img/20241114/3.gif) 

##### 库

```
 pod 'FlexLayout'
 pod 'PinLayout'
```
##### 代码说明

*代码逻辑：示例中黄色区域采用flex布局,代码参考`SFTypeView.swif`,其他UI是oc代码编写,  
oc中SFTypeView布局的关键代码：*  

```objc
_liveTypeView = [[SFTypeView alloc]init];
_liveTypeView.backgroundColor = hexColor(@"#ff0000", 0.6);
[midContentView addSubview:_liveTypeView];
[_liveTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.centerX.equalTo(midContentView);
    make.top.equalTo(midTopView.mas_bottom);
}];  

#紧接着的下一个元素布局,直接依赖了_liveTypeView的底部继续布局  
UILabel *lineL = [[UILabel alloc]init];
lineL.backgroundColor = ybLineCol;
[midContentView addSubview:lineL];
[lineL mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(midContentView);
    make.height.mas_equalTo(1.2);
    make.top.equalTo(_liveTypeView.mas_bottom).offset(20);
    make.width.equalTo(midContentView.mas_width).offset(-20);
    make.centerX.equalTo(midContentView);
}];
```

*`SFTypeView.swif`中布局完成后以通知的方式告知oc中`_liveTypeView`更新布局约束,关键代码：*

```swift
 override func layoutSubviews() {
    super.layoutSubviews()
    self.layoutFlex()
}
@objc func layoutFlex(){
    rootFlexContainer.pin.top().left().width(100%)
    rootFlexContainer.flex.layout(mode: .adjustHeight)
    print("flex=====>得到高度：%@",rootFlexContainer);
    NotificationCenter.default.post(name: Notification.Name("flexViewChange"), object: nil, userInfo: ["key":rootFlexContainer.frame.size.height])
}
```

*oc文件注册通知,接收到swift的通知后更新布局*
```objc
#pragma mark - flex
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flexViewChange:) name:@"flexViewChange" object:nil];

#pragma mark - flex
-(void)flexViewChange:(NSNotification *)noti {
    NSLog(@"flex=====>通知：%@",noti.userInfo[@"key"]);
    CGFloat flexH = [strFormat(noti.userInfo[@"key"]) floatValue];
    [_liveTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(flexH);
    }];
}

```

##### 完整代码

**Swift文件**
```swift
//
//  SFTypeView.swift
//  YBHiMo

import UIKit

import FlexLayout
import Masonry
import PinLayout

class SFTypeView: UIView {
    fileprivate let rootFlexContainer = UIView()
    @objc var itemBtn:UIButton! {
        didSet {
            debugPrint("flex=====>\(itemBtn!)")
        }
    }
    var lastHeight:Double = 0.0
    init() {
        super.init(frame: .zero)
        
        //
        let liveType = UILabel()
        liveType.text = "直播类型："
        liveType.textColor = .white
        liveType.font = UIFont.systemFont(ofSize: 14)
        liveType.backgroundColor = UIColor.hex("#000000",0.2);
                
        rootFlexContainer.flex.direction(.row).alignItems(.start).padding(0,10,0,2).backgroundColor(UIColor.hex("#fff000",0.7)).define { flex in
            // 标题
            flex.addItem(liveType).grow(0).border(1, .red)
            // 类型
            flex.addItem().grow(1).gap(5).direction(.row).wrap(.wrap).shrink(1).backgroundColor(UIColor.hex("ffffff", 0.5)).define { flex in
                
                let btn = UIButton(type: .custom)
                btn.setTitle("普通聊天室", for: .normal)
                btn.setImage(UIImage(named: "type_nor"), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
                btn.backgroundColor = UIColor.hex("#000000", 0.5)
                flex.addItem(btn).height(20).cornerRadius(10)
                
                let btn2 = UIButton(type: .custom)
                btn2.setTitle("固定密码聊天室聊码聊天", for: .normal)
                btn2.setImage(UIImage(named: "type_lock"), for: .normal)
                btn2.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                btn2.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
                btn2.backgroundColor = UIColor.hex("#000000", 0.5)
                flex.addItem(btn2).height(20).cornerRadius(10)
                itemBtn = btn2
                
                let btn3 = UIButton(type: .custom)
                btn3.setTitle("随机密码聊天室", for: .normal)
                btn3.setImage(UIImage(named: "type_random"), for: .normal)
                btn3.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                btn3.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
                btn3.backgroundColor = UIColor.hex("#000000", 0.5)
                flex.addItem(btn3).height(20).cornerRadius(10)
            }
        }
        addSubview(rootFlexContainer)
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutFlex()
    }
    
    @objc func layoutFlex(){
        rootFlexContainer.pin.top().left().width(100%)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        print("flex=====>得到高度：%@",rootFlexContainer);
       if lastHeight != rootFlexContainer.frame.size.height{
            lastHeight = rootFlexContainer.frame.size.height;
            NotificationCenter.default.post(name: Notification.Name("flexViewChange"), object: nil, userInfo: ["key":lastHeight])
        }
    }
    
    @objc func ctrItemShow(_ show:Bool){
        if show {
            itemBtn.flex.display(.flex)
        }else {
            itemBtn.flex.display(.none)
        }
        self.flex.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    class func hex(_ hex:String,_ alpha:CGFloat? = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 3) {
            cString.append(cString)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha ?? 1.0
        )
    }
}
```
**OC文件**
```objc
//
//  YBMatchAnchorPreview.m
//  YBHiMo
//

#import "YBHiMo-Swift.h"

@implementation YBMatchAnchorPreview

-(void)createUI {
    
#pragma mark - flex
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flexViewChange:) name:@"flexViewChange" object:nil];
    
    ...省略若干oc布局代码
    
#pragma mark - flex
    _liveTypeView = [[SFTypeView alloc]init];
    _liveTypeView.backgroundColor = hexColor(@"#ff0000", 0.6);
    [midContentView addSubview:_liveTypeView];
    [_liveTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(midContentView);
        make.top.equalTo(midTopView.mas_bottom);
    }];
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = ybLineCol;
    [midContentView addSubview:lineL];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(midContentView);
        make.height.mas_equalTo(1.2);
        make.top.equalTo(_liveTypeView.mas_bottom).offset(20);
        make.width.equalTo(midContentView.mas_width).offset(-20);
        make.centerX.equalTo(midContentView);
    }];
    
    ...省略若干oc布局代码
}

#pragma mark - flex
-(void)flexViewChange:(NSNotification *)noti {
    NSLog(@"flex=====>通知：%@",noti.userInfo[@"key"]);
    CGFloat flexH = [strFormat(noti.userInfo[@"key"]) floatValue];
    [_liveTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(flexH);
    }];
}
// 动态显示隐藏测试
-(void)clickCameraBtn {
    self.cameraBtn.selected = !self.cameraBtn.selected;
    [_liveTypeView ctrItemShow:!self.cameraBtn.selected];
}
@end
```

##### 快速创建一个容器盒子
**oc调用**

```objc
_inputView = [[XXYInputView alloc]init];
YBWeakSelf;
_inputView.sizeEvent = ^(double height) {
    [weakSelf sizeEvent:height];
};
[_bgView addSubview:_inputView];
// 给出默认布局
[_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.centerX.equalTo(_bgView);
    make.top.equalTo(_bgView);
}];
// 更新高度
-(void)sizeEvent:(double)height {
    [_inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
```
**代码**
```swift
import FlexLayout
import PinLayout

class <#ViewClass#>: UIView {
    
    var rootView = UIView()
    var lastHeight:Double = 0.0
    @objc var sizeEvent:((_ height:Double)->Void)?
    
    init() {
        super.init(frame: .zero);
        
        rootView.flex.alignItems(.center).define { flex in
            
            //...
        }
        addSubview(rootView)
    }
    // 布局
    func layout() {
        rootView.pin.top().right().width(100%)
        rootView.flex.layout(mode: .adjustHeight)
        if lastHeight != rootView.frame.size.height{
            lastHeight = rootView.frame.size.height;
            if let sizeEvent = sizeEvent {
                sizeEvent(lastHeight)
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout()
        return rootView.frame.size
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// UIColor 扩展
extension UIColor {
    class func hex(_ hex:String,_ alpha:CGFloat? = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 3) {
            cString.append(cString)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha ?? 1.0
        )
    }
}
/// UIButton 扩展
//import ObjectiveC
private var AssociatedObjectKey: UInt8 = 0
extension UIButton {
    var extParam: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKey) as Any?
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedObjectKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

```









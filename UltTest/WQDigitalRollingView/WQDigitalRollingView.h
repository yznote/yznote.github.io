//
//  WQDigitalRollingView.h
//  WQCocoaPodsTest
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 XiYiChuanMei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQDigitalRollingView : UIView

//MARK: - 初始化
- (instancetype)initWithFrame:(CGRect)frame orginDigital:(NSInteger)orginDigital textFont:(UIFont *)font;

//MARK: - 设置数字后动画翻滚
- (void)animationDigitalRolling:(NSInteger)orginDigital animationDigital:(NSInteger)animationDigital;

@end

//
//  PopupView.h
//  UltTest
//
//  Created by Rookie on 2017/6/24.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock)();

@interface PopupView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPopupSure:(CallBackBlock)sure andPopupCancle:(CallBackBlock)cancle;


@end

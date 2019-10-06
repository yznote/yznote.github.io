//
//  PopupView.m
//  UltTest
//
//  Created by Rookie on 2017/6/24.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "PopupView.h"
@interface PopupView()
@property (nonatomic,copy) CallBackBlock popSure;
@property (nonatomic,copy) CallBackBlock popCancle;
@end

@implementation PopupView

- (instancetype)initWithFrame:(CGRect)frame andPopupSure:(CallBackBlock)sure andPopupCancle:(CallBackBlock)cancle {
    self = [super init];
    if (self) {
        //
        self.popSure = sure;
        self.popCancle = cancle;
        
    }
    return self;
}

@end

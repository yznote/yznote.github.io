//
//  BaseUIView.m
//  UltTest
//
//  Created by Rookie on 2017/3/29.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "BaseUIView.h"

@implementation BaseUIView

-(UILabel *)addLableWithTitle:(NSString *)title{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = title;
    [self addSubview:lbl];
    return lbl;
}

@end

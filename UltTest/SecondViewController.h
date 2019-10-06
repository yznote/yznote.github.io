//
//  SecondViewController.h
//  UltTest
//
//  Created by Rookie on 2017/3/29.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CallBackBlock)(NSString *str);

@interface SecondViewController : UIViewController

@property (nonatomic,copy) CallBackBlock callBackBlock;

@end

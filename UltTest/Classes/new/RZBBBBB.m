//
//  RZBBBBB.m
//  UltTest
//
//  Created by Rookie on 2017/11/23.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "RZBBBBB.h"



@implementation RZBBBBB


+(MJRefreshGifHeader *)sssss:(SEL)aaaa xxx:(id)oooo{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:oooo refreshingAction:aaaa];
    // 设置普通状态的动画图片 (idleImages 是图片)
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:@[[UIImage imageNamed:@"jiazai.gif"]] forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    return header;
}


@end

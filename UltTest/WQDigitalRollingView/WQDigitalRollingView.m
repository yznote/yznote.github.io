//
//  WQDigitalRollingView.m
//  WQCocoaPodsTest
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 XiYiChuanMei. All rights reserved.
//

#import "WQDigitalRollingView.h"

@interface WQDigitalRollingView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *orginLabel;
@property (nonatomic, strong) UILabel *animationDigitalLabel;

@end

@implementation WQDigitalRollingView

//MARK: - 初始化
- (instancetype)initWithFrame:(CGRect)frame orginDigital:(NSInteger)orginDigital textFont:(UIFont *)font {
    self = [super initWithFrame:frame];
    if (self) {        
        self.orginLabel.font = font;
        self.animationDigitalLabel.font = font;
        self.orginLabel.text = [NSString stringWithFormat:@"%ld",(long)orginDigital];
        [self addSubview:self.scrollView];
    }
    return self;
}

//MARK: - 设置数字后动画翻滚
- (void)animationDigitalRolling:(NSInteger)orginDigital animationDigital:(NSInteger)animationDigital {
    self.orginLabel.text = [NSString stringWithFormat:@"%ld",(long)orginDigital];
    self.animationDigitalLabel.text = [NSString stringWithFormat:@"%ld",(long)animationDigital];
    CGPoint oldPoint = self.scrollView.contentOffset;
    oldPoint.y += self.scrollView.frame.size.height;
    [self.scrollView setContentOffset:oldPoint animated:YES];
}

//MARK: - setter / getter
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(0, self.bounds.size.height * 2);
        _scrollView.delegate = self;
        [_scrollView addSubview:self.orginLabel];
        [_scrollView addSubview:self.animationDigitalLabel];
    }
    return _scrollView;
}

- (UILabel *)orginLabel {
    if (!_orginLabel) {
        _orginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
        _orginLabel.textColor = [UIColor whiteColor];
        _orginLabel.font = [UIFont boldSystemFontOfSize:28];
        _orginLabel.textAlignment = NSTextAlignmentCenter;
        NSNumber *totalCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"WBAccountDailySign0TotalCount"];
        _orginLabel.text = totalCount && totalCount.integerValue ? [NSString stringWithFormat:@"%@",totalCount] : @"0";
        _orginLabel.backgroundColor = [UIColor clearColor];
    }
    return _orginLabel;
}

- (UILabel *)animationDigitalLabel {
    if (!_animationDigitalLabel) {
        _animationDigitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.bounds.size.height , self.bounds.size.width, self.bounds.size.height)];
        _animationDigitalLabel.textColor = [UIColor whiteColor];
        _animationDigitalLabel.font = [UIFont boldSystemFontOfSize:28];
        _animationDigitalLabel.textAlignment = NSTextAlignmentCenter;
        _animationDigitalLabel.backgroundColor = [UIColor clearColor];
    }
    return _animationDigitalLabel;
}

@end

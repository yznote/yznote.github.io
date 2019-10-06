//
//  MasnaryVC.m
//  UltTest
//
//  Created by Rookie on 2017/6/23.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "MasnaryVC.h"

#import "PopupView.h"
#import "qwqwq.h"

@interface MasnaryVC ()
{
    PopupView *popupView;
    qwqwq *pageC;
}
@end

@implementation MasnaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *clear = [UIColor clearColor];
    CGFloat narR,narG,narB,narA;
    [clear getRed:&narR green:&narG blue:&narB alpha:&narA];
    NSLog(@"R-%f,G-%f,B-%f,A-%f",narR,narG,narB,narA);
    
    
    UIScrollView *scrolView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(98, 230, 123, 220)];
    scrolView1.tag = 100;
    scrolView1.backgroundColor = [UIColor orangeColor];
    for (int i=0; i<5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:imageName ];
        UIImageView *imageView1 = [[UIImageView alloc]initWithImage:image];
        imageView1.frame = CGRectMake(123*i, 0, 123, 220);
        [scrolView1 addSubview:imageView1];
    }
    scrolView1.contentSize = CGSizeMake(123*5, 220);
    scrolView1.pagingEnabled = YES;//分页显示
    [self.view addSubview:scrolView1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(123*4+30, 170, 60, 20)];
    [button setTitle:@"点我啊" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [scrolView1 addSubview:button];
    //小白点
    pageC = [[qwqwq alloc]initWithFrame:CGRectMake(98, 420, 123, 30)];
    pageC.backgroundColor = [UIColor clearColor];
    pageC.numberOfPages = 5;
    pageC.tag = 120;
    pageC.pageIndicatorTintColor = [UIColor redColor]; //未选中颜色
    pageC.currentPageIndicatorTintColor = [UIColor blueColor];//当前显示颜色
    //pageC.currentPage = 0;//默认位置
    //给pageC添加事件
    UILabel *ll = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    ll.text = @"1";
    ll.textColor = [UIColor blueColor];
    [pageC setCurrentPage:0];
    [pageC setValue:ll forKeyPath:@"pageImage"];
    [self.view addSubview:pageC];
    
    
    _customeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customeBtn.backgroundColor = [UIColor redColor];
    _customeBtn.frame = CGRectMake(_WINDOW_WIDTH_/2-25, _WINDOW_HEIGHT_/2-10, 50, 20);
    [_customeBtn setTitle:@"push" forState:UIControlStateNormal];
    [_customeBtn addTarget:self action:@selector(doPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_customeBtn];
}





-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl *pageC1 = (UIPageControl *)[self.view viewWithTag:120];
    //contentOffset:scrollview当前显示区域顶点相对于frame顶点的偏移量
    pageC1.currentPage = scrollView.contentOffset.x / 123;
}

-(void)doPush {
    if (!popupView) {
        popupView = [[PopupView alloc]initWithFrame:CGRectMake(_WINDOW_WIDTH_*0.1, _WINDOW_HEIGHT_*0.2, _WINDOW_WIDTH_*0.8, _WINDOW_WIDTH_*0.6) andPopupSure:^{
            //
        } andPopupCancle:^{
            //
        }];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end

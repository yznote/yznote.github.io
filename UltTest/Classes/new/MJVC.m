//
//  MJVC.m
//  UltTest
//
//  Created by Rookie on 2017/11/23.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "MJVC.h"
#import "MineCell.h"
#import <MJRefreshGifHeader.h>
#import <UIScrollView+MJRefresh.h>
#import <UIScrollView+MJExtension.h>
#import "RZBBBBB.h"

#import "WQDigitalRollingView.h"


#define _window_width  [UIScreen mainScreen].bounds.size.width
#define _window_height [UIScreen mainScreen].bounds.size.height

@interface MJVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *array1;
    NSArray *array2;
    NSMutableArray *m_array;
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UISegmentedControl *segmentC;


@end

@implementation MJVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatMJ];
//    [self segmn];
    
//    [self upImgDownChar];
    
    
    WQDigitalRollingView *view = [[WQDigitalRollingView alloc]initWithFrame:CGRectMake(0, 100, _window_width, 50) orginDigital:6 textFont:[UIFont systemFontOfSize:15]];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view animationDigitalRolling:7 animationDigital:18];
    });
    
    
}
-(void)upImgDownChar {
    
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_click setImage:[UIImage imageNamed:@"abc"]forState:UIControlStateNormal];
    
    [btn_click setTitle:@"我的主帖"forState:UIControlStateNormal];
    btn_click.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_click setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn_click setBackgroundColor:[UIColor grayColor]];
    [btn_click addTarget:self action:@selector(clickAction)forControlEvents:UIControlEventTouchUpInside];
    btn_click.frame =CGRectMake(50,200, 58,70);
    
    CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
    CGFloat spaceHeight = 20;
    //设置按钮图片偏移
    [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height),0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
    //设置按钮标题偏移
    [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(spaceHeight, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
    // 加载按钮到视图
    [self.view addSubview:btn_click];
    
    [UIColor colorWithRed:0.38 green:0.60 blue:0.16 alpha:1.00];
    [UIColor colorWithHue:0.13 saturation:0.67 brightness:1.00 alpha:1.00];
    
}
-(void)clickAction {
    
}
-(void)segmn{
    [self.view addSubview:self.segmentC];
    
    UIImageView *sssss = [[UIImageView alloc]initWithFrame:CGRectMake(20, 200, 200, 200)];
    [sssss setImage:[self drawBckgroundImage1]];
    sssss.backgroundColor = [UIColor blueColor];
    [self.view addSubview:sssss];
}
-(UISegmentedControl *)segmentC {
    if (!_segmentC) {
        NSArray *items = @[@"寄存中",@"已发货",@"已收货",@"已兑换"];
        _segmentC = [[UISegmentedControl alloc]initWithItems:items];
        _segmentC.tintColor = [UIColor greenColor];
        _segmentC.layer.borderColor = [UIColor whiteColor].CGColor;
        _segmentC.layer.borderWidth = 1;
        _segmentC.selectedSegmentIndex = 0;
        
        _segmentC.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 40);
        
        [_segmentC addTarget:self action:@selector(cickChangeSegment:) forControlEvents:UIControlEventValueChanged];
        NSDictionary *nomalC = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor yellowColor], NSForegroundColorAttributeName, nil];
        [_segmentC setTitleTextAttributes:nomalC forState:UIControlStateNormal];
        NSDictionary *selC = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
        [_segmentC setTitleTextAttributes:selC forState:UIControlStateSelected];
        
        _segmentC.backgroundColor = [UIColor greenColor];
        [_segmentC setBackgroundImage:[self drawBckgroundImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentC setBackgroundImage:[self drawBckgroundImage1] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
//        _segmentC.layer.masksToBounds = YES;
//        _segmentC.layer.cornerRadius = 20;
        
        //设置间隔图片   //[self drawBckgroundImage]
//        [_segmentC setDividerImage:[UIImage imageNamed:@"wawa_sub_mid"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //底部圆角
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_segmentC.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = _segmentC.bounds;
//        maskLayer.path = maskPath.CGPath;
//        _segmentC.layer.mask = maskLayer;
        
       
    }
    return _segmentC;
}

-(void)cickChangeSegment:(UISegmentedControl *)segment {
    NSLog(@"----");
}

//背景色
-(UIImage *)drawBckgroundImage {
    CGSize size = CGSizeMake(self.view.frame.size.width/4, 40);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 251/255.0, 107/255.0, 113/255.0, 1);//红色
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = 10;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

-(UIImage *)drawBckgroundImage1 {
    CGSize size = CGSizeMake(self.view.frame.size.width/4, 40);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 200/255.0, 200/255.0, 200/255.0, 1);//灰色色
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = 10;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return roundedImage;
}

-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)creatMJ {
    [self.view addSubview:self.tableView];
    m_array = [NSMutableArray array];
    array1 = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"];
    array2 = @[@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R"];
}

#pragma mark -
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return m_array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = (MineCell *)[tableView dequeueReusableCellWithIdentifier:@"MineCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameL.text = m_array[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _window_width, _window_height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"MineCell"];
       //表头
        _tableView.mj_header = [RZBBBBB sssss:@selector(loadNewData) xxx:self];
        
    }
    return _tableView;
}
-(void)loadNewData {
    [m_array removeAllObjects];
    [m_array addObjectsFromArray:array1];
    
    [_tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
@end
/*
 MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
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
 _tableView.mj_header = header;
 */

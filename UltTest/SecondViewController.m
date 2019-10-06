//
//  SecondViewController.m
//  UltTest
//
//  Created by Rookie on 2017/3/29.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

{
    double angle;
    UIButton *aBtn;
}
- (IBAction)popToA:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *writeTF;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    //[self doAnimation];
    
    //[self btnWithImage];
    
}
-(void)btnWithImage {
    
    aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aBtn setTitle:@"testAAAAAA" forState:UIControlStateNormal];
    [aBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    
    aBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 180, 8, 0);
    aBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    aBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [aBtn addTarget:self action:@selector(doABtn) forControlEvents:UIControlEventTouchUpInside];
    aBtn.frame = CGRectMake(0, 90, 200, 30);
    aBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:aBtn];
    
}

-(void)doABtn {
    [aBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
}

-(void)doAnimation {
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(50, 50, 200, 200);
    image.image = [UIImage imageNamed:@"zz"];
    [self.view addSubview:image];
    CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI*0.38);
    /*关于M_PI
     #define M_PI     3.14159265358979323846264338327950288
     其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
     旋转方向为：顺时针旋转
     
     */
    image.transform = transform;//旋转
    [self.view setBackgroundColor:[UIColor redColor]];//设置背景为红色，效果直观明显
    
    [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector:@selector(transformAction) userInfo: nil repeats: YES];
}

-(void)transformAction {
    angle = angle + 0.01;//angle角度 double angle;
    if (angle > 6.28) {//大于 M_PI*2(360度) 角度再次从0开始
        angle = 0;
    }
    CGAffineTransform transform=CGAffineTransformMakeRotation(angle);
    self.view.transform = transform;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)popToA:(id)sender {
    
    self.callBackBlock(_writeTF.text);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

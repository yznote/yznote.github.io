//
//  FirstViewController.m
//  UltTest
//
//  Created by Rookie on 2017/3/29.
//  Copyright © 2017年 Rookie. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "BaseUIView.h"
#import "LogFirstCell.h"

@interface FirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
    UIAlertView *testAlert;
}
- (IBAction)pushToB:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *showTF;

@property (nonatomic,strong) UILabel *label;

@property (nonatomic,strong) UICollectionView *firstCollection;

@end
static NSString* IDENTIFIER = @"collectionCell";
@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat fcW = 300;
    CGFloat fcH = 400;
    CGFloat fcX = 30;
    CGFloat fcY =250;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _firstCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(fcX, fcY, fcW, fcH)collectionViewLayout:layout];
    
    _firstCollection.dataSource = self;
    _firstCollection.delegate = self;
    
    //[_firstCollection registerClass:[FirstLogCell class] forCellWithReuseIdentifier:IDENTIFIER];
    
    UINib *nib = [UINib nibWithNibName:@"LogFirstCell" bundle:nil];
    [_firstCollection registerNib:nib forCellWithReuseIdentifier:IDENTIFIER];
    
    [_firstCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [_firstCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    //_firstCollection.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:_firstCollection];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

-(LogFirstCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LogFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.imageIV.image= [UIImage imageNamed:@"选中"];
    cell.backgroundColor = [UIColor brownColor];
    
    if ((int)indexPath == 7) {
        
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 20);
}
-(UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor =[UIColor grayColor];
        
    }else{
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor redColor];
    }
    return view;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zi",indexPath.item);
}


- (IBAction)pushToB:(id)sender {
    
//    SecondViewController * bVC = [[SecondViewController alloc]init];
//    
//    __weak FirstViewController *weakSelf = self;
//    bVC.callBackBlock = ^(NSString *str){
//        weakSelf.showTF.text = str;
//    };
//    
//    [self.navigationController pushViewController:bVC animated:YES];
    
    testAlert = [[UIAlertView alloc]initWithTitle:@"tes" message:@"测试" delegate:self cancelButtonTitle:@"quxiao" otherButtonTitles:@"suer", nil];
    [testAlert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [testAlert dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == testAlert) {
        if (buttonIndex == 0) {
            return;
        }else{
                SecondViewController * bVC = [[SecondViewController alloc]init];
            
                __weak FirstViewController *weakSelf = self;
                bVC.callBackBlock = ^(NSString *str){
                    weakSelf.showTF.text = str;
                };
            
                [self.navigationController pushViewController:bVC animated:YES];
        }
    }
}
@end

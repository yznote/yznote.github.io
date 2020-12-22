---
layout:     post
title:      Braintree
subtitle:  	Objective-C、Swift
date:       2020-12-22 15:30:30 GMT+0800
author:     Rookie
header-img: 
catalog: true
stickie: false
tags:
    - Paypal
---

#### iOS集成Braintree+Paypal支付

**官方文档**  

[iOS SDK Url0](https://developers.braintreepayments.com/guides/paypal/client-side/ios/v4)  
[iOS SDK Url1](https://developers.braintreepayments.com/guides/paypal/client-side/ios/v4#setup-for-app-switch)  

**第一步:创建沙盒/生产账号**

>[沙盒注册链接](https://www.braintreepayments.com/sandbox)  
[沙盒登陆链接](https://sandbox.braintreegateway.com/)  
[生产登陆链接](https://www.braintreegateway.com/login)

注册、登陆之后点击`设置-API-Generate New Tokenization Key`生成沙盒/生产环境的`Token`如图所示:

![图1](/img/20201222/1.png)

**第二步:下载SDK**  

*Pod*
```
pod 'BraintreeDropIn'
```

*手动导入*
>链接:[https://github.com/braintree/braintree_ios](https://github.com/braintree/braintree_ios)  
导入文件:`BraintreeCore、BraintreePaypal`

**第三步:URL Schemes**  
>格式:bunldID+.payments  
在 targets - info - Url Types中添加 bunldID+.payments  

**第四步:代码**

`AppDelegate`
```
#import "BTAppSwitch.h"

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [BTAppSwitch setReturnURLScheme:@"com.rk.xxxx.payments"];
    
    return YES;
} 

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.scheme localizedCaseInsensitiveCompare:@"com.rk.xxxx.payments"] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url options:options];
    }
    
    return NO;
}
```
`支付页面`
```
#import "ViewController.h"
#import "BraintreePayPal.h"
#import "SVProgressHUD.h"

@interface ViewController ()<BTViewControllerPresentingDelegate>

@property (strong, nonatomic) BTPayPalDriver *payPalDriver;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [button setTitle:@"paypal" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (BTPayPalDriver *)payPalDriver
{
    if (!_payPalDriver) {
        //TODO 替换为自己的 token
        BTAPIClient *braintreeClient = [[BTAPIClient alloc] initWithAuthorization:@"production_bn7dy6sh_m7rf4gn9dmswttsh"];
//        BTAPIClient *braintreeClient = [[BTAPIClient alloc] initWithAuthorization:@"sandbox_38cjh9r7_tpmv9kr9kpxvnrkn"];
        _payPalDriver = [[BTPayPalDriver alloc] initWithAPIClient:braintreeClient];
        _payPalDriver.viewControllerPresentingDelegate = self;
    }
    return _payPalDriver;
}

- (void)buttonOnClick
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD show];
    
    NSString *price = @"199";
    NSString *orderNo = @"100320_201222135431766";
    BTPayPalRequest *request = [[BTPayPalRequest alloc] initWithAmount:price];
    request.currencyCode = @"USD";
    
    BTPayPalLineItem *item = [[BTPayPalLineItem alloc] initWithQuantity:@"1" unitAmount:price name:@"商品名称" kind:BTPayPalLineItemKindDebit];
    item.productCode = orderNo; //订单编号
    request.lineItems = @[item];

    [self.payPalDriver requestOneTimePayment:request completion:^(BTPayPalAccountNonce * _Nullable tokenizedPayPalAccount, NSError * _Nullable error) {
          
        if (tokenizedPayPalAccount) {
            NSLog(@"-->> paypal 支付成功 nonce:%@", tokenizedPayPalAccount.nonce);
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            //todo 调用后台接口，传递 tokenizedPayPalAccount.nonce
            
        } else if (error) {
            // Handle error here...
            NSLog(@"paypal 支付失败 ：%@", error);
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            
        } else {
            // Buyer canceled payment approval
            [SVProgressHUD showErrorWithStatus:@"支付取消"];
        }
        
        [SVProgressHUD dismissWithDelay:3];
    }];
}

#pragma mark - BTViewControllerPresentingDelegate
// Required
- (void)paymentDriver:(id)paymentDriver requestsPresentationOfViewController:(UIViewController *)viewController
{
    [SVProgressHUD dismiss];
    viewController.modalPresentationStyle = 0;
    [self presentViewController:viewController animated:YES completion:nil];
}

// Required
- (void)paymentDriver:(id)paymentDriver requestsDismissalOfViewController:(UIViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD show];
    }];
}


@end
```

#### 客户信息

>生产:  
https://www.braintreegateway.com/login  
登录用户名  
wesay  
kaifa123  
沙盒:  
https://sandbox.braintreegateway.com/  
ID wesaygaming  
PW Kaifa123  

[参考1](https://www.jianshu.com/p/1a59e0a0ed28)  
[参考2](https://github.com/hw20101101/TestBraintree)


























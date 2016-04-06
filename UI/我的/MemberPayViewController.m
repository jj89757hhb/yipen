//
//  MemberPayViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
// 会费支付

#import "MemberPayViewController.h"
#import "AppPurchase.h"
@interface MemberPayViewController ()

@end

@implementation MemberPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会费支付";
    self.payBtn.clipsToBounds=YES;
    self.payBtn.layer.cornerRadius=5;
    if (self.enterType==1) {
        self.memberTypeL.text=@"商家会员费";
        [self.bgIV setImage:[UIImage imageNamed:@"会员价格形状-商家"]];
        [self.costL setText:@"¥98/年"];
    }
    else{
        [self.costL setText:@"¥1/年"];
    }
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self.payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
      AppPurchase *app=[AppPurchase sharedAppPurchase];
    [app requestProducts];
}

-(void)payAction{
    AppPurchase *app=[AppPurchase sharedAppPurchase];
    [app willPurchase];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
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

@end

//
//  RechargeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "RechargeViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
@interface RechargeViewController ()

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"充值";
    self.submitBtn.clipsToBounds=YES;
    self.submitBtn.layer.cornerRadius=5;
    [self.submitBtn addTarget:self action:@selector(willPayAction) forControlEvents:UIControlEventTouchUpInside];
    self.line.backgroundColor=Line_Color;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [_selectBtn addTarget:self action:@selector(selectWeixPay) forControlEvents:UIControlEventTouchUpInside];
    [_select2Btn addTarget:self action:@selector(selectZfbPay) forControlEvents:UIControlEventTouchUpInside];
}


-(void)willPayAction{
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}


-(void)selectWeixPay{
    [_selectBtn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    [_select2Btn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
}

-(void)selectZfbPay{
    [_selectBtn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
    [_select2Btn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
}





-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

//
//  ManagerWithdrawViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ManagerWithdrawViewController.h"
#import "ZiFuBaoWithdrawViewController.h"
#import "WeixinAuthorViewController.h"
@interface ManagerWithdrawViewController ()

@end

@implementation ManagerWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"管理提现账号";
    self.authorBtn.layer.borderWidth=1;
    self.authorBtn.layer.borderColor=[UIColor redColor].CGColor;
    self.authorBtn.layer.cornerRadius=3;
    self.authorBtn.clipsToBounds=YES;
    [_authorBtn addTarget:self action:@selector(authorAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.author2Btn.layer.borderWidth=1;
    self.author2Btn.layer.borderColor=[UIColor redColor].CGColor;
    self.author2Btn.layer.cornerRadius=3;
    self.author2Btn.clipsToBounds=YES;
    
    
    self.view.backgroundColor=WHITEColor;
    [_author2Btn addTarget:self action:@selector(authorAction2) forControlEvents:UIControlEventTouchUpInside];
    self.line.backgroundColor=Line_Color;
    self.line2.backgroundColor=Line_Color;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)authorAction{
    WeixinAuthorViewController *ctr=[[WeixinAuthorViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
}
//支付宝
-(void)authorAction2{
    ZiFuBaoWithdrawViewController *ctr=[[ZiFuBaoWithdrawViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
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

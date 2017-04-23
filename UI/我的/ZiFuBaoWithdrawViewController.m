//
//  ZiFuBaoWithdrawViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/9.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ZiFuBaoWithdrawViewController.h"

@interface ZiFuBaoWithdrawViewController ()

@end

@implementation ZiFuBaoWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"支付宝提现"];
    [_authorBtn addTarget:self action:@selector(authorAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)authorAction{
    if (_nameTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (_accountTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入支付宝账号"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",@"1",@"Type",_accountTF.text,@"Account",_nameTF.text,@"Name", nil];
    [HttpConnection SetWDAccount:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"已授权"];
                [DataSource sharedDataSource].userInfo.AliAccount=_accountTF.text;
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
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

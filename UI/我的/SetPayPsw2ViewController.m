//
//  SetPayPsw2ViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SetPayPsw2ViewController.h"

@interface SetPayPsw2ViewController ()

@end

@implementation SetPayPsw2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"设置支付密码";

    
    self.subBtn.layer.cornerRadius=5;
    self.subBtn.clipsToBounds=YES;
    self.line.backgroundColor=Line_Color;
    [self.subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)subAction{
    if ([_payPsw1.text length]!=6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位长度的支付密码"];
        return;
    }
    if ([_payPsw2.text length]==0) {
          [SVProgressHUD showErrorWithStatus:@"请确认支付密码"];
        return;
    }
    if (![_payPsw1.text isEqualToString:_payPsw2.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    [SVProgressHUD show];
    NSString *md5_Psw = [CommonFun stringTomd5:_payPsw1.text];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",md5_Psw,@"Password",_vcode, @"vcode", nil];
    [HttpConnection SetPayPassword:dic WithBlock:^(id response, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        else{
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
            }
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

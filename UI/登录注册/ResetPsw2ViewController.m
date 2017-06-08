//
//  ResetPsw2ViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ResetPsw2ViewController.h"

@interface ResetPsw2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *payPsw1;
@property (weak, nonatomic) IBOutlet UITextField *payPsw2;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation ResetPsw2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    self.title=@"忘记密码";
    self.subBtn.layer.cornerRadius=5;
    self.subBtn.clipsToBounds=YES;
    self.line.backgroundColor=Line_Color;
    [self.subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    _payPsw1.secureTextEntry = YES;
    _payPsw2.secureTextEntry = YES;
//    _payPsw1.keyboardType=UIKeyboardTypeNumberPad;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)subAction{
    if ([_payPsw1.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if ([_payPsw2.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    if (![_payPsw1.text isEqualToString:_payPsw2.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    [SVProgressHUD show];
    NSString *md5_Psw = [CommonFun stringTomd5:_payPsw1.text];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:md5_Psw,@"Pwd",_mobile, @"Mobile", nil];
    [HttpConnection FindPwdTwo:dic WithBlock:^(id response, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        else{
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
            }
        }
        
    }];
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

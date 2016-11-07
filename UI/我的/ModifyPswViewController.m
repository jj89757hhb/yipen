//
//  ModifyPswViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ModifyPswViewController.h"

@interface ModifyPswViewController ()

@end

@implementation ModifyPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureBtn.layer.cornerRadius=5;
    self.sureBtn.clipsToBounds=YES;
    self.title=@"修改密码";
    self.line1.backgroundColor=Line_Color;
    self.line2.backgroundColor=Line_Color;
}
- (IBAction)sureAction:(id)sender {
    if (_oldTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
        return;
    }
    if (_theNewTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if (_aginTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码"];
        return;
    }
    if (![_theNewTF.text isEqualToString:_aginTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    WS(weakSelf)
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",_oldTF.text,@"OldPwd",_theNewTF.text,@"NewPwd",nil];
    [HttpConnection ChangePwd:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

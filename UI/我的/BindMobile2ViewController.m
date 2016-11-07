//
//  BindMobile2ViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BindMobile2ViewController.h"

@interface BindMobile2ViewController ()

@end

@implementation BindMobile2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"绑定手机";
    self.subBtn.clipsToBounds=YES;
    self.subBtn.layer.cornerRadius=5;
}


-(void)subAction{
    [self setNewPsw];
//    [SVProgressHUD show];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNewNum,@"Mobile", [DataSource sharedDataSource].userInfo.ID,@"Uid",nil];
//    WS(weakSelf)
//    [HttpConnection BindMobile:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD showSuccessWithStatus:@"修改手机成功"];
//                [weakSelf setNewPsw];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            else{
//                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:ErrorMessage];
//        }
//        
//    }];
}

-(void)setNewPsw{
      [SVProgressHUD show];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_pswTF.text,@"Pwd", [DataSource sharedDataSource].userInfo.ID,@"Uid",nil];
    WS(weakSelf)
    [HttpConnection BindMobile:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"设置密码成功"];
                [weakSelf setNewPsw];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
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

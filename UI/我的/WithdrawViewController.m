//
//  WithdrawViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "WithdrawViewController.h"

@interface WithdrawViewController ()
@property(nonatomic,strong)NSString *type;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type=@"1";
    self.title=@"提现";
    if ([DataSource sharedDataSource].userInfo.AliAccount.length) {
        self.account2L.text=[NSString stringWithFormat:@"支付宝: %@",[DataSource sharedDataSource].userInfo.AliAccount];
    }
    else{
        self.account2L.text=@"未绑定账号";
    }
    
    self.subBtn.clipsToBounds=YES;
    self.subBtn.layer.cornerRadius=5;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAccount)];
    [self.bg1 addGestureRecognizer:tap];
    [_subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    if ([DataSource sharedDataSource].userInfo.WeChatName.length==0&&[DataSource sharedDataSource].userInfo.AliAccount.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您还未绑定任意提现账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_subBtn setEnabled:NO];
    }
}

-(void)selectAccount{
    UIActionSheet *action=[UIActionSheet bk_actionSheetWithTitle:@"选择账号"];
    [action bk_addButtonWithTitle:@"支付宝" handler:^{
        if ([DataSource sharedDataSource].userInfo.AliAccount.length) {
             self.account2L.text=[NSString stringWithFormat:@"支付宝: %@",[DataSource sharedDataSource].userInfo.AliAccount];
        }
        else{
            self.account2L.text=@"未绑定账号";
        }
        
          self.type=@"1";
    }];
    [action bk_addButtonWithTitle:@"微信" handler:^{
        if ([DataSource sharedDataSource].userInfo.WeChatName.length) {
            self.account2L.text=[NSString stringWithFormat:@"微信: %@",[DataSource sharedDataSource].userInfo.WeChatName];
        }
        else{
            self.account2L.text=@"未绑定账号";
        }
          self.type=@"2";
    }];
    [action showInView:self.view];
}

-(void)subAction{
    if ([_fundTF.text integerValue]<0.1) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"提现金额不能小于0.1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    [SVProgressHUD show];
    NSMutableDictionary *dic=nil;
    if ([self.type isEqualToString:@"1"]) {
        dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_fundTF.text,@"Money", [DataSource sharedDataSource].userInfo.AliAccount,@"Account",_type,@"AccountType", nil];
    }
    else{
        dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_fundTF.text,@"Money", [DataSource sharedDataSource].userInfo.WeChatName,@"Account",_type,@"AccountType", nil];
    }
    [HttpConnection withDrawal:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"已提交提现金额，请耐心等待审核"];
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


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
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

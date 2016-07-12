//
//  AddAddressViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"编辑地址";
//    [self.view setFrame:CGRectOffset(self.view.frame, 0, -64)];
 
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf setAddress:nil];
    }];
    [self initBottom];
    [self showAddress];
    if (!_info||[_info.IsDefault boolValue]) {//新增入口 或者是默认地址
        [bottomView setHidden:YES];
    }
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];

}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initBottom{
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor=WHITEColor;
    addBtn=[[UIButton alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-15*2, 40)];
    [addBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [addBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor redColor]];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    addBtn.layer.cornerRadius=5;
    addBtn.clipsToBounds=YES;
    [bottomView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(setDefaultAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
}
-(void)setDefaultAddress{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_info.ID,@"AID",_OAID,@"OAID",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection DefaultAddress:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                [NotificationCenter postNotificationName:@"queryAddress" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
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


-(void)showAddress{
    _shoujianTF.text=_info.Contacter;
    _phoneTF.text=_info.Mobile;
    _addressTF.text=_info.Address;
}
-(void)setAddress:(UIButton*)sender{
    if ([_shoujianTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人姓名"];
        return;
    }
    if ([_phoneTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入联系电话"];
        return;
    }
    if ([_addressTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *dic=nil;
    WS(weakSelf)
    if (!_info) {//添加地址
        dic=[[NSDictionary alloc] initWithObjectsAndKeys:_shoujianTF.text,@"Contacter",_phoneTF.text,@"mobile",_addressTF.text,@"address",[DataSource sharedDataSource].userInfo.ID,@"UID",nil];
        [HttpConnection AddAddress:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    [NotificationCenter postNotificationName:@"queryAddress" object:nil];
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
    else{
          dic=[[NSDictionary alloc] initWithObjectsAndKeys:_shoujianTF.text,@"Contacter",_phoneTF.text,@"mobile",_addressTF.text,@"address",[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"AID",nil];
        [HttpConnection EditAddress:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    [NotificationCenter postNotificationName:@"queryAddress" object:nil];
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

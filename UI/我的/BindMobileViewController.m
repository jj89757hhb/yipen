//
//  BindMobileViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BindMobileViewController.h"
#import "BindMobile2ViewController.h"
#import "MyWebViewViewController.h"
@interface BindMobileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *aggreL;
@property(nonatomic,strong)NSString *vCode;

@end

@implementation BindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeBtn.clipsToBounds=YES;
    self.codeBtn.layer.cornerRadius=3;
    [self.codeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.codeBtn.layer.borderWidth=1;
    self.codeBtn.layer.borderColor=[UIColor grayColor].CGColor;
    [self.codeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn.layer.cornerRadius=5;
    self.nextBtn.clipsToBounds=YES;
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
//    self.nextBtn.layer.borderWidth=1;
    self.title=@"修改绑定手机";
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aggreementAction)];
    [_aggreL setUserInteractionEnabled:YES];
    [_aggreL addGestureRecognizer:tap];
}

-(void)aggreementAction{
    MyWebViewViewController *ctr=[[MyWebViewViewController alloc] init];
    ctr.urlStr=user_agreement_Url;
    ctr.title=@"服务协议";
    [self.navigationController pushViewController:ctr animated:YES];
}


//获取验证码
-(void)getCodeAction{
    if (_mobileTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }

    [self timerAction];
    //    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"uid",_mobileTF.text,@"mobile", nil];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_mobileTF.text,@"Mobile", nil];
    [HttpConnection FindPwd:dic WithBlock:^(id response, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
            [self invalidateTimer];
        }
        else{
            
            if ([[response objectForKey:@"ok"] boolValue]==YES) {
                NSString *vcode=response[@"vcode"];
                self.vCode=vcode;
                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"reason"]];
                [SVProgressHUD dismiss];
                
                //                [self nextAction];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
                [self invalidateTimer];
            }
        }
        
    }];

    
    
}

-(void)timerAction{
    counter=90;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)invalidateTimer{
    [timer invalidate];
    counter=0;
    [_codeBtn setTitle:@"免费获取验证码" forState:UIControlStateNormal];
    [_codeBtn setEnabled:YES];
}

-(void)timerCounter{
    counter--;
    [_codeBtn setEnabled:NO];
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获得",counter] forState:UIControlStateNormal];
    if (counter<=0) {
        
        [self invalidateTimer];
    }
}

-(void)nextAction{
    if (![_codeTF.text isEqualToString:_vCode]) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入有误"];
        return;
    }
    if (_mobileTF.text.length!=11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    [self setNewPhone];
}

-(void)setNewPhone{
        [SVProgressHUD show];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_mobileTF.text,@"Mobile", [DataSource sharedDataSource].userInfo.ID,@"Uid",nil];
        WS(weakSelf)
        [HttpConnection BindMobile:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
//                    [SVProgressHUD showSuccessWithStatus:@"修改手机成功"];
//                    [weakSelf setNewPsw];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                    BindMobile2ViewController *ctr=[[BindMobile2ViewController alloc] initWithNibName:nil bundle:nil];
                    ctr.phoneNewNum=_mobileTF.text;
                    [self.navigationController pushViewController:ctr animated:YES];
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

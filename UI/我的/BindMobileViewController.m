//
//  BindMobileViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BindMobileViewController.h"
#import "BindMobile2ViewController.h"
@interface BindMobileViewController ()

@end

@implementation BindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeBtn.clipsToBounds=YES;
    self.codeBtn.layer.cornerRadius=3;
    [self.codeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.codeBtn.layer.borderWidth=1;
    self.codeBtn.layer.borderColor=[UIColor grayColor].CGColor;
    
    self.nextBtn.layer.cornerRadius=5;
    self.nextBtn.clipsToBounds=YES;
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
//    self.nextBtn.layer.borderWidth=1;
    self.title=@"修改绑定手机";
}


//获取验证码
-(void)getCodeAction{
    if (_mobileTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
//    [SVProgressHUD show];
//    [self timerAction];
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_mobileTF.text,@"Mobile", nil];
//    [HttpConnection registerUserOfGetCodeWithDic:dic WithBlock:^(id response, NSError *error) {
//        //        [SVProgressHUD dismiss];
//        if (!error) {
//            
//            NSString *ok=response[@"ok"];
//            NSString *vcode=response[@"vcode"];
//            if ([ok isEqualToString:@"TRUE"]) {
//                NSLog(@"验证码:%@",vcode);
//                [SVProgressHUD showSuccessWithStatus:@"验证码已发送到您手机，请注意查收"];
//            }
//            else{
//                //                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
//                [SVProgressHUD showInfoWithStatus:response[@"reason"]];
//                [self invalidateTimer];
//            }
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:ErrorMessage];
//            [self invalidateTimer];
//        }
//        
//    }];
    
    
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
    BindMobile2ViewController *ctr=[[BindMobile2ViewController alloc] initWithNibName:nil bundle:nil];
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

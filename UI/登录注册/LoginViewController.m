//
//  LoginViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/30.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "LoginViewController.h"
#import "ShareView.h"
#import "ResetPsw1ViewController.h"
#import "MyWebViewViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *mobileL;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UILabel *passwordL;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *goLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIView *BottombgView;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UILabel *thirdL;

@property (weak, nonatomic) IBOutlet UIView *loginLine1;

@property (weak, nonatomic) IBOutlet UIView *loginLine2;
@property(nonatomic,strong) NSString *vCode;//验证码

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:VIEWBACKCOLOR];
    [_goLoginBtn setBackgroundColor:Light_Blue];
    _goLoginBtn.layer.cornerRadius=5;
    _goLoginBtn.clipsToBounds=YES;
    [_loginBtn setTitleColor:Blue_selectColor forState:UIControlStateNormal];
    [_registerBtn setTitleColor:Gray_unselectColor forState:UIControlStateNormal];
    _loginBtn.titleLabel.textColor=Blue_selectColor;
    _registerBtn.titleLabel.textColor=Gray_unselectColor;
    [_mobileL setTextColor:LIGHTBLACK];
    [_passwordL setTextColor:LIGHTBLACK];
    [_loginLine1 setBackgroundColor:Line_Color];
    [_loginLine2 setBackgroundColor:Line_Color];
    _mobileTF.delegate=self;
    _passwordTF.delegate=self;
//    _mobileTF.text=@"18857871640";
//    _mobileTF.text=@"13164954971";
//    _passwordTF.text=@"123456";
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"18857871640",@"Mobile", nil];
//    [HttpConnection registerUserOfGetCodeWithDic:dic WithBlock:^(id response, NSError *error) {
//        
//    }];
    [NotificationCenter addObserver:self selector:@selector(sinaWeiboLogin:) name:@"sinaWeiboLogin" object:nil];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)sinaWeiboLogin:(NSNotification*)noti{
    NSDictionary *userInfo=noti.userInfo;
    
    NSMutableDictionary *mutaDic=[[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [mutaDic setObject:OS_Version forKey:@"OS"];
//    NSString *sid=userInfo[@"sid"];
//    NSString *outSiteAccessToken=userInfo[@"outSiteAccessToken"];
//    NSString *userName=userInfo[@"userName"];
//    NSString *ositeAppid=userInfo[@"ositeAppid"];
//    NSString *NickName=userInfo[@"NickName"];
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:sid,@"sid",OS_Version,@"OS",AppKey_Sina,@"ositeAppid",nil];
    [HttpConnection RegisterSinaUser:mutaDic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                
            }
        }
        else{
            
        }
    }];
}

//注册切换
- (IBAction)registerAction:(id)sender {
    

    [self hideLoginView:YES];
    if (!mobileTF) {
         [self initRegisterVieww];
    }
    [self hideRegisterView:NO];
    [_loginBtn setTitleColor:Gray_unselectColor forState:UIControlStateNormal];
    [_registerBtn setTitleColor:Blue_selectColor forState:UIControlStateNormal];
}
//登录切换
- (IBAction)loginAction:(id)sender {
  
    [self hideRegisterView:YES];
    [self hideLoginView:NO];
    [_loginBtn setTitleColor:Blue_selectColor forState:UIControlStateNormal];
    [_registerBtn setTitleColor:Gray_unselectColor forState:UIControlStateNormal];
}
//登录
- (IBAction)goLoginAcition:(id)sender {
    if ([_mobileTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if ([_passwordTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_mobileTF.text,@"Mobile",_passwordTF.text,@"Pwd",@"ios",@"OS",@"udid",@"DID", nil];//DID
    [HttpConnection loginWithPhone:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            
            NSString *ok=response[@"ok"];
            if ([ok isEqualToString:@"TRUE"]) {
                NSLog(@"登录成功");
                [SVProgressHUD dismiss];
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeView"object:nil];
                [NotificationCenter postNotificationName:@"QueryPersonalInfo" object:nil];
                   
//                [SVProgressHUD showSuccessWithStatus:@"验证码已发送到您手机，请注意查收"];
            }
            else{
                //                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
                [SVProgressHUD showInfoWithStatus:response[@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }

    }];
  
}

//忘记密码
- (IBAction)forgetAction:(id)sender {
    ResetPsw1ViewController *ctr=[[ResetPsw1ViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (IBAction)weixinBtn:(id)sender {
    [ShareView authWeixinLogin];
}

- (IBAction)qqAction:(id)sender {
    [ShareView authQQLogin];
}

- (IBAction)weiboAction:(id)sender {
    [ShareView authSinaWeibo];
}

//创建注册视图
-(void)initRegisterVieww{
    float offX=10;
    float offY=10;
 
    registerBgView=[[UIView alloc] init];
    [self.view addSubview:registerBgView];
    [registerBgView setUserInteractionEnabled:YES];
    registerBgView.backgroundColor=WHITEColor;
    registerBgView.layer.borderColor=Line_Color.CGColor;
    registerBgView.layer.borderWidth=1;
//    [registerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(offX);
//        make.right.equalTo(self.view.mas_right).with.offset(-offX);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-80);
//        make.height.mas_equalTo(150);
//        
//    }];
    [registerBgView setFrame:CGRectMake(offX, SCREEN_HEIGHT-80-150, SCREEN_WIDTH-offX*2, 150)];
    float textField_height=35;
    mobileTF=[[UITextField alloc] initWithFrame:CGRectMake(offX, offY, 220, textField_height)];
    mobileTF.placeholder=@"输入手机号";
    mobileTF.delegate=self;
    mobileTF.keyboardType=UIKeyboardTypePhonePad;
    codeTF=[[UITextField alloc] initWithFrame:CGRectMake(offY, CGRectGetMaxY(mobileTF.frame), 220, textField_height)];
    codeTF.keyboardType=UIKeyboardTypeDefault;
    codeTF.placeholder=@"请输入验证码";
    codeTF.delegate=self;
    password1=[[UITextField alloc] initWithFrame:CGRectMake(offY, CGRectGetMaxY(codeTF.frame), 220, textField_height)];
    password1.keyboardType=UIKeyboardTypeDefault;
    password1.secureTextEntry=YES;
    password1.delegate=self;
    password1.placeholder=@"请输入登录密码";
    password2=[[UITextField alloc] initWithFrame:CGRectMake(offY, CGRectGetMaxY(password1.frame), 220, textField_height)];
     password2.secureTextEntry=YES;
    password2.keyboardType=UIKeyboardTypeDefault;
    password2.delegate=self;
    password2.placeholder=@"请确认登录密码";
    [registerBgView addSubview:mobileTF];
    [registerBgView addSubview:codeTF];
    [registerBgView addSubview:password1];
    [registerBgView addSubview:password2];
    verifyBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-130,mobileTF.frame.origin.y , 120, 30)];
    verifyBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [verifyBtn setTitle:@"免费获取验证码" forState:UIControlStateNormal];
    [verifyBtn setTitleColor:Blue_selectColor forState:UIControlStateNormal];
    [registerBgView addSubview:verifyBtn];
    [verifyBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(verifyBtn.frame.origin.x-10, 0, 0.5, textField_height+offY)];
    line.backgroundColor=Line_Color;

    
    float height=0.5;
    float width=SCREEN_WIDTH-20;
    line1=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mobileTF.frame), width,height)];
    line2=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(codeTF.frame),width, height)];
    line3=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(password1.frame), width, height)];
//    line1.backgroundColor=Login_Lable_Color;
    line1.backgroundColor=Line_Color;
    line2.backgroundColor=Line_Color;
    line3.backgroundColor=Line_Color;
    [registerBgView addSubview:line1];
    [registerBgView addSubview:line2];
    [registerBgView addSubview:line3];
    [registerBgView addSubview:line];
    
//    registerBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(line3.frame)+10, registerBgView.frame.size.width-20*2, 30)];
    registerBtn=[[UIButton alloc] init];
    registerBtn.layer.cornerRadius=5;
    registerBtn.clipsToBounds=YES;
       [self.view addSubview:registerBtn];
//    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(offX*2);
//        make.right.equalTo(self.view.mas_right).with.offset(-offX*2);
//        make.top.equalTo(registerBgView.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(35);
//    }];
    [registerBtn setFrame:CGRectMake(10, CGRectGetMaxY(registerBgView.frame)+10, SCREEN_WIDTH-(20*2), 35)];
    [registerBtn setTitle:@"马上注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:Light_Blue];
    [registerBtn addTarget:self action:@selector(toRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setUserInteractionEnabled:YES];
 
    agreementL=[[UILabel alloc] init];
    agreementL.textAlignment=NSTextAlignmentCenter;
    agreementL.font=[UIFont systemFontOfSize:13];
    agreementL.textColor=LIGHTBLACK;
//    [registerBgView addSubview:agreementL];
    [self.view addSubview:agreementL];
    [agreementL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(offX*2);
        make.right.equalTo(self.view.mas_right).with.offset(-offX*2);
        make.top.equalTo(registerBtn.mas_bottom).with.offset(10);
        make.height.mas_equalTo(20);
    }];
//    [agreementL setFrame:CGRectMake(10, registerBgView.frame.size.height-30, SCREEN_WIDTH-10*2, 20)];
    agreementL.text=@"注册表示你同意并遵守《易盘会员协议》";
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aggreementAction)];
    [agreementL addGestureRecognizer:tap];
    [agreementL setUserInteractionEnabled:YES];
}

-(void)aggreementAction{
    MyWebViewViewController *ctr=[[MyWebViewViewController alloc] init];
    ctr.urlStr=user_agreement_Url;
    ctr.title=@"服务协议";
    [self.navigationController pushViewController:ctr animated:YES];
}
//获取验证码
-(void)getCodeAction{
    if (mobileTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    [SVProgressHUD show];
    [self timerAction];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:mobileTF.text,@"Mobile", nil];
    [HttpConnection registerUserOfGetCodeWithDic:dic WithBlock:^(id response, NSError *error) {
//        [SVProgressHUD dismiss];
        if (!error) {
       
            NSString *ok=response[@"ok"];
            NSString *vcode=response[@"vcode"];
            if ([ok isEqualToString:@"TRUE"]) {
                NSLog(@"验证码:%@",vcode);
                self.vCode=vcode;
                [SVProgressHUD showSuccessWithStatus:@"验证码已发送到您手机，请注意查收"];
            }
            else{
//                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
                [SVProgressHUD showInfoWithStatus:response[@"reason"]];
                [self invalidateTimer];
            }
        }
        else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
                [self invalidateTimer];
        }
        
    }];
    

    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:mobileTF.text
//                                   zone:@"86"
//                       customIdentifier:nil
//                                 result:^(NSError *error){
////
//       if (!error) {
//         NSLog(@"获取验证码成功");
//             [SVProgressHUD dismiss];
//           [SVProgressHUD showSuccessWithStatus:@"验证码已发送到您手机，请注意查收"];
//        }
//        else {
//         NSLog(@"错误信息：%@",error);
//            [self invalidateTimer];
//            [SVProgressHUD showInfoWithStatus:@"发送失败"];
//        }
//       }
//    ];
    
    
}

-(void)timerAction{
    counter=90;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)invalidateTimer{
    [timer invalidate];
    counter=0;
    [verifyBtn setTitle:@"免费获取验证码" forState:UIControlStateNormal];
    [verifyBtn setEnabled:YES];
}

-(void)timerCounter{
    counter--;
    [verifyBtn setEnabled:NO];
      [verifyBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获得",counter] forState:UIControlStateNormal];
    if (counter<=0) {
        
        [self invalidateTimer];
    }
}

//注册
-(void)toRegisterAction{
    if (mobileTF.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (codeTF.text.length==0) {
         [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (password1.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
        return;
    }
    if (password2.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    if (![password1.text isEqualToString:password2.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    if (![self.vCode isEqualToString:codeTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入有误"];
        return;
    }
    [SVProgressHUD show];
    [self registerUser];
//    WS(weakSelf)
//    [SMSSDK commitVerificationCode:codeTF.text phoneNumber:mobileTF.text zone:@"86" result:^(NSError *error) {
//   
//        if (!error) {
//            NSLog(@"验证成功");
//            [SVProgressHUD dismiss];
//            [weakSelf registerUser];
//        }
//        else
//        {
//            NSLog(@"错误信息:%@",error);
//            [SVProgressHUD showErrorWithStatus:@"验证码输入有误"];
//        }
//    }];
    
    
 
}

-(void)registerUser{
    [SVProgressHUD show];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:mobileTF.text,@"Mobile",password1.text,@"Pwd", nil];
    [HttpConnection registerUserWithDic:dic WithBlock:^(id response, NSError *error) {
        //        [SVProgressHUD dismiss];
        NSString *ok=response[@"ok"];
        NSString *vcode=response[@"vcode"];
        if (!error) {
            if ([ok isEqualToString:@"TRUE"]) {
                NSLog(@"验证码:%@",vcode);
                [SVProgressHUD showSuccessWithStatus:@"注册成功，立即登录"];
                //
                _mobileTF.text = mobileTF.text;
                _passwordTF.text = password1.text;
                [self goLoginAcition:nil];//自动登录
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

-(void)hideLoginView:(BOOL)ishide{
    [_mobileL setHidden:ishide];
    [_mobileTF setHidden:ishide];
//    [_loginBtn setHidden:ishide];
    [_goLoginBtn setHidden:ishide];
    [_passwordL setHidden:ishide];
    [_passwordTF setHidden:ishide];
    [_forgetBtn setHidden:ishide];
    [_thirdL setHidden:ishide];
    [_weiboBtn setHidden:ishide];
    [_qqBtn setHidden:ishide];
    [_weixinBtn setHidden:ishide];
    [_BottombgView setHidden:ishide];
}


-(void)hideRegisterView:(BOOL)ishide{
    [mobileTF setHidden:ishide];
    [codeTF setHidden:ishide];
    [password1 setHidden:ishide];
    [password2 setHidden:ishide];
    [line1 setHidden:ishide];
    [line2 setHidden:ishide];
    [line3 setHidden:ishide];
    [registerBgView setHidden:ishide];
    [registerBtn setHidden:ishide];
    [agreementL setHidden:ishide];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.view.frame.origin.y==0) {
         [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-250, self.view.frame.size.width, self.view.frame.size.height)];
    }
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
     [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
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

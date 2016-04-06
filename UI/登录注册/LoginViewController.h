//
//  LoginViewController.h
//  panjing
//
//  Created by 华斌 胡 on 15/12/30.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController{
    UITextField *mobileTF;
    UIButton *verifyBtn;
    UITextField *codeTF;
    UITextField *password1;
    UITextField *password2;
    UIButton *registerBtn;
    UILabel *agreementL;
    UIView *line1;
    UIView *line2;
    UIView *line3;
    UIView *registerBgView;//注册背景视图
    NSTimer *timer;
    NSInteger counter;
    
}

@end

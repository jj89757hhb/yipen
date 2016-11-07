//
//  BindMobile2ViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface BindMobile2ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property(nonatomic,strong)NSString *phoneNewNum;//新的手机号
@end

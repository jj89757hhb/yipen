//
//  SetPayPsw2ViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface SetPayPsw2ViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *payPsw1;
@property (weak, nonatomic) IBOutlet UITextField *payPsw2;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property(nonatomic,strong)NSString *vcode;
@end

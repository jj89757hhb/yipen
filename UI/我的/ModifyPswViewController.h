//
//  ModifyPswViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPswViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *oldTF;

@property (weak, nonatomic) IBOutlet UITextField *theNewTF;
@property (weak, nonatomic) IBOutlet UITextField *aginTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@end

//
//  MemberPayViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface MemberPayViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;

@property (weak, nonatomic) IBOutlet UILabel *memberTypeL;
@property (weak, nonatomic) IBOutlet UILabel *costL;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property(nonatomic,assign)NSInteger enterType;//0 普通会员 1 商家会员
@end

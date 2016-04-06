//
//  MyQRCodeViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "ShareView.h"
@interface MyQRCodeViewController : BaseViewController{
    ShareView *share;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UIImageView *QRBgIV;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

//
//  AddAddressViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressInfo.h"
@interface AddAddressViewController : BaseViewController{
    UIButton *addBtn;
    UIView *bottomView;
    
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UILabel *shoujianL;
@property (weak, nonatomic) IBOutlet UITextField *shoujianTF;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property(nonatomic,strong)AddressInfo *info;
@property(nonatomic,strong)NSString *OAID;
@end

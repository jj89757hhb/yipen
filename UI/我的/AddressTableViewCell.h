//
//  AddressTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfo.h"
@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property(nonatomic,strong)AddressInfo *info;

@end

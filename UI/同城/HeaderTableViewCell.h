//
//  HeaderTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
typedef void(^AttentionBlock)(id sender);
@interface HeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *verifyIV;
@property (weak, nonatomic) IBOutlet UIButton *attentBtn;
@property (nonatomic,copy) AttentionBlock attentionBlock;
@property(nonatomic,strong)ActivityInfo *info;

@end

//
//  AttentionTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPUserInfo.h"
typedef void(^AttentionBlock)(id sender);
@interface AttentionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UIImageView *authIV;

@property (weak, nonatomic) IBOutlet UILabel *nickNameL;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property(nonatomic,strong)YPUserInfo *info;
@property(nonatomic,weak)NSIndexPath *index;
@property(nonatomic,copy)AttentionBlock attentionBlock;

@end

//
//  MessageCommentTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenJinInfo.h"
#import "YPUserInfo.h"
@interface MessageCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *replyL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *nickNameL;
@property(nonatomic,strong)PenJinInfo *info;
@property (weak, nonatomic) IBOutlet UIImageView *certificateIV;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@end

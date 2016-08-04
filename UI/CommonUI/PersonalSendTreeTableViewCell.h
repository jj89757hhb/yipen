//
//  PersonalSendTreeTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenJinInfo.h"
typedef void(^ShareBlock)(id sender);//
@interface PersonalSendTreeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UIImageView *verifyIV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *viewL;
@property (weak, nonatomic) IBOutlet UILabel *praiseL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property(nonatomic,strong)PenJinInfo *info;
@property(nonatomic,copy)ShareBlock shareBlock;
@property(nonatomic,weak)NSIndexPath *index;
@end

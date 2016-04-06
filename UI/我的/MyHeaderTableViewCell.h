//
//  MyHeaderTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyHeaderCellBlock)(id sender);
@interface MyHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *tagL;
@property (weak, nonatomic) IBOutlet UIImageView *levelL;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIImageView *huiyuanIV;
@property (weak, nonatomic) IBOutlet UILabel *shareNumL;
@property (weak, nonatomic) IBOutlet UILabel *shareL;
@property (weak, nonatomic) IBOutlet UILabel *attentionNumL;
@property (weak, nonatomic) IBOutlet UILabel *attentionL;
@property (weak, nonatomic) IBOutlet UILabel *fansNumL;
@property (weak, nonatomic) IBOutlet UILabel *fansL;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *fansBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic,copy) MyHeaderCellBlock myHeaderCellBlock;
@end

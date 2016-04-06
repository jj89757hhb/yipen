//
//  PersonalHomeHeadTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHomeHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UIImageView *verifyIV;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UILabel *fansL;
@property (weak, nonatomic) IBOutlet UILabel *verifyL;
@property (weak, nonatomic) IBOutlet UILabel *levelL;

@end

//
//  PersonalHomeHeadTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "PersonalHomeHeadTableViewCell.h"

@implementation PersonalHomeHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.attentionBtn.layer.cornerRadius=3;
    self.attentionBtn.clipsToBounds=YES;
    self.msgBtn.layer.cornerRadius=3;
    self.msgBtn.clipsToBounds=YES;
    self.fansL.layer.cornerRadius=5;
    self.fansL.clipsToBounds=YES;
    self.verifyL.layer.cornerRadius=5;
    self.verifyL.clipsToBounds=YES;
    self.levelL.layer.cornerRadius=5;
    self.levelL.clipsToBounds=YES;
    self.headIV.clipsToBounds=YES;
    self.headIV.layer.cornerRadius=30;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

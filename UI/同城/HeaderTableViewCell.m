//
//  HeaderTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  头像头部视图

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.attentBtn.layer.cornerRadius=3;
    self.attentBtn.clipsToBounds=YES;
    self.attentBtn.layer.borderWidth=0.5;
    self.attentBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

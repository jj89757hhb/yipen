//
//  SentTreePictureTableViewCell1.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SentTreePictureTableViewCell1.h"

@implementation SentTreePictureTableViewCell1

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.y1_width.constant=0.5;
    self.y2_width.constant=0.5;
    self.y3_width.constant=0.5;
    self.y_height.constant=0.5;
}

@end

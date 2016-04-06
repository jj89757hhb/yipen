//
//  MessageCommentTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageCommentTableViewCell.h"

@implementation MessageCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headIV.clipsToBounds=YES;
    self.headIV.contentMode=UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

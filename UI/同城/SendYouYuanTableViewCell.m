//
//  SendYouYuanTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendYouYuanTableViewCell.h"

@implementation SendYouYuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.line1.backgroundColor=Line_Color;
    self.line2.backgroundColor=Line_Color;
    self.line3.backgroundColor=Line_Color;
    self.line4.backgroundColor=Line_Color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

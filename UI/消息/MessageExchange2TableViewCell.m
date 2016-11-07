//
//  MessageExchange2TableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageExchange2TableViewCell.h"

@implementation MessageExchange2TableViewCell

- (void)awakeFromNib {
        [super awakeFromNib];
    // Initialization code
    self.orderBtn.layer.cornerRadius=3;
    self.orderBtn.clipsToBounds=YES;
    _headIV.contentMode=UIViewContentModeScaleAspectFill;
    _headIV.clipsToBounds=YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MessageExchangeTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageExchangeTableViewCell.h"

@implementation MessageExchangeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.aggreeBtn.layer.cornerRadius=3;
    self.aggreeBtn.clipsToBounds=YES;
    self.aggreeBtn.layer.borderWidth=0.5;
    self.aggreeBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.aggreeBtn.layer.cornerRadius=3;
    
    self.refuseBtn.clipsToBounds=YES;
    self.refuseBtn.layer.borderWidth=0.5;
    self.refuseBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.refuseBtn.layer.cornerRadius=3;
    
    self.replyPriceBtn.clipsToBounds=YES;
    self.replyPriceBtn.layer.borderWidth=0.5;
    self.replyPriceBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.replyPriceBtn.layer.cornerRadius=3;
//    [_replyPriceBtn addTarget:self action:@selector(replyPriceAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)replyPriceAction{
    if (_replyPriceBlock) {
        _replyPriceBlock(nil);
    }
}


@end

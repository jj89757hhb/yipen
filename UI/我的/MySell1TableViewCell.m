//
//  MySell1TableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/1.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MySell1TableViewCell.h"

@implementation MySell1TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.sendGoodsBtn addTarget:self action:@selector(sendGoodsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.msgBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sendGoodsAction{
    if (_sendGoodsBlock) {
        _sendGoodsBlock(nil);
    }
    
}

-(void)msgAction{
    if (_msgBlock) {
        _msgBlock(nil);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

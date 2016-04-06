//
//  AuctionRecordTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AuctionRecordTableViewCell.h"

@implementation AuctionRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecord:(AuctionRecord *)record{
    _record=record;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:record.userInfo.UserHeader] placeholderImage:Default_Image];
    _nameL.text=record.userInfo.NickName;
    _priceL.text=[NSString stringWithFormat:@"¥ %@",record.Offer];
    _timeL.text=record.Createtime;
    if (_indexPath.row==0) {
        _tagL.text=@"领先";
        _tagL.backgroundColor=RedColor;
    }
    else{
        _tagL.text=@"出局";
        _tagL.backgroundColor=[UIColor grayColor];
    }
}

@end

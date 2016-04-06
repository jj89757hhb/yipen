//
//  AddressTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setInfo:(AddressInfo *)info{
    _nameL.text=info.Contacter;
    _phoneL.text=info.Mobile;
    _addressL.text=info.Address;
    if ([info.IsDefault boolValue]) {
         _addressL.text=[NSString stringWithFormat:@"[默认] %@",info.Address];
    }
}
@end

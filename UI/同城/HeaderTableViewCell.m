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
    _headIV.layer.cornerRadius=50/2.f;
    _headIV.clipsToBounds=YES;
        UIColor *color=[UIColor darkGrayColor];
    _timeL.textColor=color;
    [_attentBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setInfo:(ActivityInfo *)info{
    _info=info;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:nil];
    _nameL.text=info.userInfo.NickName;
    _timeL.text=info.CreateTime;
    if ([_info.userInfo.IsFocus boolValue]) {
        [_attentBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [_attentBtn setUserInteractionEnabled:NO];
    }
    else{
        [_attentBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_attentBtn setUserInteractionEnabled:YES];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)attentionAction:(UIButton*)sender{
    if (_attentionBlock) {
        _attentionBlock(nil);
    }
}

@end

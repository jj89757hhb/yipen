//
//  AttentionTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ExpertTableViewCell.h"

@implementation ExpertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.attentionBtn.clipsToBounds=YES;
    self.attentionBtn.layer.cornerRadius=3;
    self.headIV.layer.cornerRadius=55/2.f;
    self.headIV.clipsToBounds=YES;
    [_attentionBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(YPUserInfo *)info{
    _info=info;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.UserHeader] placeholderImage:Default_Image];
    _nickNameL.text=info.NickName;
   
//    if ([info.IsFocus boolValue]) {
//        [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
//        [_attentionBtn setUserInteractionEnabled:NO];
//        
//    }
//    else{
//        [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
//        [_attentionBtn setUserInteractionEnabled:YES];
//    }
    [_levelIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lv%@",info.Levels]]];
    
    if ([_info.RoleType isEqualToString:@"1"]||[_info.RoleType isEqualToString:@"2"]) {
        
    }
    else{//未开通
        [_memberIV setHidden:YES];
    }
    if (![_info.IsCertifi boolValue]) {
        [_authIV setHidden:YES];
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
     [_nickNameL sizeToFit];
    [_memberIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickNameL.mas_right).offset(5);
        
    }];
    
}

-(void)attentionAction{
    if (_attentionBlock) {
        _attentionBlock(_index);
    }
    if ([_attentionBtn.titleLabel.text isEqualToString:@"请 教"]) {
        [_attentionBtn setTitle:@"已请教" forState:UIControlStateNormal];
        [_attentionBtn setBackgroundColor:[UIColor colorWithRed:80/255 green:147/255 blue:21/255 alpha:1]];
    }
    else{
        [_attentionBtn setTitle:@"请 教" forState:UIControlStateNormal];
          [_attentionBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    
}


@end

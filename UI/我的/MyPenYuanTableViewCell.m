//
//  MyPenYuanTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyPenYuanTableViewCell.h"

@implementation MyPenYuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _headIV.clipsToBounds=YES;
    _headIV.layer.cornerRadius=30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
    _nameL.text=info.userInfo.NickName;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:nil];
    [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Path] placeholderImage:nil];
    _timeL.text=info.Createtime;
    _sortL.text=[NSString stringWithFormat:@"品种: %@",info.Varieties];
    _changeL.text=[NSString stringWithFormat:@"想换: %@",info.ChangeVarieties];
    _tree_HeightL.text=[NSString stringWithFormat:@"树高: %@CM",info.Height];
    _locationL.text=[NSString stringWithFormat:@"位置 :%@",info.Location];
    _changeNumL.text=[NSString stringWithFormat:@"%@人想换",info.BrowseNum];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_nameL sizeToFit];
    [_memberIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameL.mas_right).offset(5);
        
    }];
}
@end

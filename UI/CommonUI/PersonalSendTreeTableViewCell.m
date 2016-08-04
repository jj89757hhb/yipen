//
//  PersonalSendTreeTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "PersonalSendTreeTableViewCell.h"

@implementation PersonalSendTreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _headIV.clipsToBounds=YES;
    _headIV.contentMode=UIViewContentModeScaleAspectFill;
    _treeIV.clipsToBounds=YES;
    _treeIV.contentMode=UIViewContentModeScaleAspectFill;
    [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
//    _titleL.text=info.Title;
    _contentL.text=info.Descript;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:Default_Image];
    _nameL.text=info.userInfo.NickName;
    if (info.Attach.count) {
        [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Attach[0]] placeholderImage:Default_Image];
    }
    _timeL.text=info.Createtime;
    _praiseL.text=[NSString stringWithFormat:@"赞%@",info.PraisedNum];
    _viewL.text=[NSString stringWithFormat:@"浏览%@",info.BrowseNum];
    _commentL.text=[NSString stringWithFormat:@"评论%@",info.CommentsNum ];
//    if ([_info.InfoType integerValue]==1) {
//        
//    }
//    else if ([_info.InfoType integerValue]==2) {
//        if ([_info.IsSale boolValue]) {
//            
//        }
//    }
//    else if ([_info.InfoType integerValue]==3) {
//        
//    }
//    else if ([_info.InfoType integerValue]==4) {
//        
//    }
//    else if ([_info.InfoType integerValue]==5) {
//        
//    }
    [_statusBtn setBackgroundColor:RedColor];
    if ([_info.IsSale boolValue]) {
        [_statusBtn setTitle:@"出售中" forState:UIControlStateNormal];
        if ([_info.Status integerValue]!=1) {
              [_statusBtn setTitle:@"已出售" forState:UIControlStateNormal];
              [_statusBtn setBackgroundColor:GRAYCOLOR];
        }
    }
    else{
        [_statusBtn setTitle:@"分享的" forState:UIControlStateNormal];
        [_statusBtn setBackgroundColor:GRAYCOLOR];
    }
    if ([_info.IsAuction boolValue]) {
        [_statusBtn setTitle:@"拍卖中" forState:UIControlStateNormal];
           [_statusBtn setBackgroundColor:RedColor];
//        if ([_info.Status integerValue]!=1) {
//            [_statusBtn setTitle:@"已结拍" forState:UIControlStateNormal];
//            [_statusBtn setBackgroundColor:GRAYCOLOR];
//        }
    }
   
    [_shareBtn setBackgroundColor: [UIColor colorWithHexString:@"aa6b00" alpha:1]];
}

-(void)shareAction{
    if (_shareBlock) {
        _shareBlock(_index);
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
 
}

@end

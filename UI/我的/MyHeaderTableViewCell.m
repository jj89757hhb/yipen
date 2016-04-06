//
//  MyHeaderTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyHeaderTableViewCell.h"

@implementation MyHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.attentionBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.fansBtn addTarget:self action:@selector(fansAction) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn setBackgroundColor:GRAYCOLOR];
    self.editBtn.layer.cornerRadius=3;
    self.editBtn.clipsToBounds=YES;
    self.editBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.editBtn.layer.borderWidth=1;
    [self.editBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    self.headIV.clipsToBounds=YES;
    self.headIV.layer.cornerRadius=30;
    self.shareNumL.textColor=BLUECOLOR;
    self.attentionNumL.textColor=BLUECOLOR;
    self.fansNumL.textColor=BLUECOLOR;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.5);
    }];
    self.line.backgroundColor=Line_Color;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//分享
-(void)shareAction{
    if (_myHeaderCellBlock) {
        _myHeaderCellBlock(_shareBtn);
    }
}

//关注
-(void)attentionAction{
    if (_myHeaderCellBlock) {
        _myHeaderCellBlock(_attentionBtn);
    }
}

//粉丝
-(void)fansAction{
    if (_myHeaderCellBlock) {
        _myHeaderCellBlock(_fansBtn);
    }
}



@end

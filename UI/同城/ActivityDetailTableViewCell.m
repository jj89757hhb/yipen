//
//  ActivityDetailTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityDetailTableViewCell.h"

@implementation ActivityDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleL=[[UILabel alloc] init];
        [_titleL setFont:[UIFont systemFontOfSize:16]];
        self.timeL=[[UILabel alloc] init];
        self.addressL=[[UILabel alloc] init];
        self.masterL=[[UILabel alloc] init];
        self.contentL=[[UILabel alloc] init];
        self.priceL=[[UILabel alloc] init];
        self.praiseView=[[PraiseView alloc] init];
        [self.contentView addSubview:_titleL];
        [self.contentView addSubview:_timeL];
        [self.contentView addSubview:_addressL];
        [self.contentView addSubview:_masterL];
        [self.contentView addSubview:_contentL];
        [self.contentView addSubview:_priceL];
        [self.contentView addSubview:_praiseView];
        
        UIFont *font=[UIFont systemFontOfSize:14];
        UIColor *color=[UIColor darkGrayColor];
        _timeL.font=font;
        _addressL.font=font;
        _masterL.font=font;
        _timeL.font=font;
        _contentL.font=font;
        _priceL.font=font;
        _contentL.numberOfLines=0;
        
        _timeL.textColor=color;
        _addressL.textColor=color;
        _masterL.textColor=color;
        _contentL.textColor=color;
        _priceL.textColor=color;
       
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    float offX=8;
    float offY=10;
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(offY);
        make.left.offset(offX);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(offY);
        make.right.offset(-offX);
        make.width.offset(100);
    }];
    _priceL.textAlignment=NSTextAlignmentRight;
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleL.mas_bottom).offset(offY);
        make.left.offset(offX);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeL.mas_bottom).offset(offY);
        make.left.offset(offX);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    [_masterL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressL.mas_bottom).offset(offY);
        make.left.offset(offX);
        make.width.offset(SCREEN_WIDTH-120);
    }];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_masterL.mas_bottom).offset(offY);
        make.left.offset(offX);
        make.right.offset(-offX);
    }];
    [_contentL sizeToFit];
    [_praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(50);
        make.top.equalTo(_contentL.mas_bottom).offset(offY);
    }];
    [_praiseView initViewUsers:_info.Praised uid:_info.UID praiseNum:_info.PraisedNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInfo:(ActivityInfo *)info{
    _titleL.text=info.Title;
    _contentL.text=info.Message;
    _timeL.text=@"时间:2016年2月20日-29";
    _masterL.text=@"杭州盆景协会";
    _addressL.text=@"杭州市西湖天地大草坪";
    _priceL.text=@"门票: 50¥/人";
    
}

@end

//
//  ActivityTableViewCell1.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityTableViewCell1.h"

@implementation ActivityTableViewCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView=[[UIView alloc] init];
        self.headIV=[[UIImageView alloc] init];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [_headIV addGestureRecognizer:tap];
        [_headIV setUserInteractionEnabled:YES];
        self.nameL=[[UILabel alloc] init];
        _nameL.textColor=[UIColor darkGrayColor];
        _nameL.font=[UIFont systemFontOfSize:14];
        self.createTimeL=[[UILabel alloc] init];
         _createTimeL.font=[UIFont systemFontOfSize:12];
        _createTimeL.textColor=LIGHTBLACK;
        
        self.timeL=[[UILabel alloc] init];
        _timeL.textColor=[UIColor darkGrayColor];
        _timeL.font=[UIFont systemFontOfSize:12];
        
        self.priceL=[[UILabel alloc] init];
        self.treeIV=[[UIImageView alloc] init];
        _treeIV.contentMode=UIViewContentModeScaleAspectFill;
        _treeIV.clipsToBounds=YES;
        self.priceL=[[UILabel alloc] init];
        self.addressL=[[UILabel alloc] init];
        self.titleL=[[UILabel alloc] init];
        self.contentL=[[UILabel alloc] init];
        self.praiseL=[[UILabel alloc] init];
        self.viewL=[[UILabel alloc] init];
        _praiseL.textColor=[UIColor grayColor];
        _viewL.textColor=[UIColor grayColor];
        _praiseL.font=[UIFont systemFontOfSize:11];
         _praiseL.textAlignment=NSTextAlignmentCenter;
        _viewL.font=[UIFont systemFontOfSize:11];
        _viewL.textAlignment=NSTextAlignmentCenter;
       
        
        
        
        [self.contentView addSubview:_bgView];
        [_bgView addSubview:_praiseL];
        [_bgView addSubview:_viewL];
        [_bgView addSubview:_headIV];
        [_bgView addSubview:_nameL];
        [_bgView addSubview:_createTimeL];
        [_bgView addSubview:_treeIV];
        [_bgView addSubview:_timeL];
        [_bgView addSubview:_priceL];
        [_bgView addSubview:_addressL];
        [_bgView addSubview:_titleL];
        [_bgView addSubview:_contentL];
        [_timeL setTextColor:MIDDLEBLACK];
        [_priceL setTextColor:MIDDLEBLACK];
        [_addressL setTextColor:MIDDLEBLACK];
        [_titleL setTextColor:DEEPBLACK];
        [_contentL setTextColor:MIDDLEBLACK];
        _bgView.layer.borderColor=Tree_Line.CGColor;
        _bgView.layer.borderWidth=1;
     
        _titleL.font=[UIFont systemFontOfSize:16];
        _contentL.font=[UIFont systemFontOfSize:14];
        UIFont *font=[UIFont systemFontOfSize:12];
        _timeL.font=font;
        _priceL.font=font;
        _joinNumL.font=font;
        _addressL.font=font;
        
        
     
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//       _titleL.text=@"第二届亚太盆景展览";
//     _timeL.text=@"2016年2月10日-20日";
//    _addressL.text=@"杭州市西湖大草坪";
//    _priceL.text=@"费用: 50元/人";
//    _joinNumL.text=@"100人参加";
    float offX=10;
    float offY=10;
    [_headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(offY);
        make.width.offset(35);
        make.height.offset(35);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIV.mas_right).offset(5);
        make.topMargin.equalTo(_headIV.mas_topMargin);
    }];
    [_createTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIV.mas_right).offset(5);
        make.top.equalTo(_nameL.mas_bottom).offset(0);
    }];
    _headIV.clipsToBounds=YES;
    _headIV.layer.cornerRadius=35/2.f;
    
    [_viewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.offset(10);
    }];
    [_praiseL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.top.equalTo(_viewL.mas_bottom).offset(1);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.top.offset(offY);
        make.bottom.offset(-offY);
        
    }];
    [_treeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIV.mas_bottom).offset(5);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(120);
    }];
//    NSString *url=@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg";
//    [_treeIV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
//    _treeIV.backgroundColor=[UIColor greenColor];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.right.offset(-100);
        make.height.offset(20);
        make.top.equalTo(_treeIV.mas_bottom).offset(offY);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.top.equalTo(_titleL.mas_bottom).offset(0);
    }];
    _contentL.numberOfLines=0;
    [_contentL sizeToFit];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
//        make.right.offset(-100);
        make.height.offset(20);
        make.top.equalTo(_contentL.mas_bottom).offset(0);
    }];
    

    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.height.offset(20);
        make.top.equalTo(_timeL.mas_bottom).offset(0);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        //        make.right.offset(-100);
        make.height.offset(20);
        make.top.equalTo(_addressL.mas_bottom).offset(0);
    }];
  
    
//    [_joinNumL mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.left.offset(offX);
//        make.right.offset(-offX);
//        make.top.equalTo(_treeIV.mas_bottom).offset(offY);
//    }];
}

-(void)setInfo:(ActivityInfo *)info{
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:nil];
    _titleL.text=info.Title;
    _contentL.text=info.Message;
    _createTimeL.text=info.CreateTime;
    _nameL.text=info.userInfo.NickName;
    
    NSString *url=info.Attach[0];
    [_treeIV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    _timeL.text=@"2016年2月10日-20日";
    _addressL.text=@"杭州市西湖区孤山";
    _priceL.text=@"费用: 50元/人";
    [_viewL setText:@"120人浏览"];
    [_praiseL setText:@"12人看好"];
}

-(void)tapGesture{
    if (_clickHeadBlock) {
        _clickHeadBlock(nil);
    }
}
@end

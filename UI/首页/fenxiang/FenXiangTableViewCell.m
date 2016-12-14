//
//  FenXiangTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "FenXiangTableViewCell.h"
#import "CommentInfo.h"
#import "CustomImageView.h"
#import "CommentLabel.h"
static float fenXiang_offX=10;
static float fenXiang_offY=10;
static float fenXiang_HeadSize=50;
static float image_Size =150;//图片大小
static float image_offX =10;

@implementation FenXiangTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.topView=[[UIView alloc] init];
        _topView.backgroundColor=VIEWBACKCOLOR;
        [self.contentView addSubview:_topView];
        
        self.headView=[[UIImageView alloc] init];
        [_headView setUserInteractionEnabled:YES];
        _headView.layer.cornerRadius=fenXiang_HeadSize/2.f;
        _headView.clipsToBounds=YES;
//        [_headView setBackgroundColor:[UIColor redColor]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headAction)];
        [_headView addGestureRecognizer:tap];
        self.certificateIV=[[UIImageView alloc] init];
        self.certificateIV.image=[UIImage imageNamed:@"个人认证"];
        self.imageScrollView=[[UIScrollView alloc] init];
        UITapGestureRecognizer *scrolltap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
        scrolltap.delegate=self;
        [_imageScrollView addGestureRecognizer:scrolltap];
        
//        _imageScrollView.canCancelContentTouches=YES;
//        _imageScrollView.delaysContentTouches=YES;
        self.nickNameL=[[UILabel alloc] init];
        [_nickNameL setFont:[UIFont systemFontOfSize:16]];
        self.levelIV=[[UIImageView alloc] init];
//        _levelIV.image=[UIImage imageNamed:@"lv1"];
        self.memberIV=[[UIImageView alloc] init];
        _memberIV.image=[UIImage imageNamed:@"个人会员"];
        self.timeL=[[UILabel alloc] init];
        self.attentBtn=[[UIButton alloc] init];
        self.treeIcon=[[UIImageView alloc] init];
        self.descriptionL=[[UILabel alloc] init];
        [_descriptionL setTextColor:MIDDLEBLACK];
        [_descriptionL setFont:[UIFont systemFontOfSize:16]];
        _descriptionL.numberOfLines=0;
        
        self.titleL=[[UILabel alloc] init];
        [_titleL setFont:[UIFont systemFontOfSize:16]];
        _titleL.numberOfLines=1;
        
        self.heightL=[[UILabel alloc] init];
        self.heightNumL=[[UILabel alloc] init];
        self.widthL=[[UILabel alloc] init];
        self.widthNumL=[[UILabel alloc] init];
        self.diameterL=[[UILabel alloc] init];
        self.diameterNumL=[[UILabel alloc] init];
        self.ageL=[[UILabel alloc] init];
        self.ageNumL=[[UILabel alloc] init];
        self.commentIV=[[UIImageView alloc] init];
        
        self.praiseBtn=[[UIButton alloc] init];
        self.collectBtn=[[UIButton alloc] init];
        self.commentBtn=[[UIButton alloc] init];
        self.chatBtn=[[UIButton alloc] init];
        //
        [_timeL setFont:[UIFont systemFontOfSize:12]];
        [_timeL setTextColor:[UIColor lightGrayColor]];
        [_attentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_attentBtn setTitle:@"+关注" forState:UIControlStateNormal];
        _attentBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _attentBtn.layer.borderColor=Line_Color.CGColor;
        _attentBtn.layer.borderWidth=0.5;
        _attentBtn.layer.cornerRadius=3;
        _attentBtn.clipsToBounds=YES;
        [_attentBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _certificateIV.image=[UIImage imageNamed:@"个人认证"];
        _treeIcon.image=[UIImage imageNamed:@"标签"];
        
        
//        self.imageScrollView=[[UIScrollView alloc] init];
        self.generalGB=[[UIView alloc] init];
//        _generalGB.layer.cornerRadius=5;
        _generalGB.layer.borderColor=Tree_Line.CGColor;
        _generalGB.layer.borderWidth=0.5;
        _generalGB.clipsToBounds=YES;
        _generalGB.backgroundColor=Tree_BgColor;
        
        self.h_line=[[UIView alloc] init];
        self.v_line=[[UIView alloc] init];
        _h_line.backgroundColor=Tree_Line;
        _v_line.backgroundColor=Tree_Line;
        [_generalGB addSubview:_h_line];
        [_generalGB addSubview:_v_line];
        
        self.v_line2=[[UIView alloc] init];
        self.v_line3=[[UIView alloc] init];
        _v_line2.backgroundColor=Tree_Line;
        _v_line3.backgroundColor=Tree_Line;
        
        
        
        [_generalGB addSubview:_v_line2];
        [_generalGB addSubview:_v_line3];
        
        [self.contentView addSubview:_generalGB];
        [self.contentView addSubview:_headView];
//        [_headView addSubview:_certificateIV];
        [self.contentView addSubview:_certificateIV];
        [self.contentView addSubview:_memberIV];
          [self.contentView addSubview:_imageScrollView];
          [self.contentView addSubview:_nickNameL];
          [self.contentView addSubview:_levelIV];
          [self.contentView addSubview:_timeL];
          [self.contentView addSubview:_attentBtn];
          [self.contentView addSubview:_treeIcon];
         [self.contentView addSubview:_titleL];
          [self.contentView addSubview:_descriptionL];
        
        
          [_generalGB addSubview:_heightL];
          [_generalGB addSubview:_heightNumL];
          [_generalGB addSubview:_widthL];
          [_generalGB addSubview:_widthNumL];
          [_generalGB addSubview:_diameterL];
        [_generalGB addSubview:_diameterNumL];
        [_generalGB addSubview:_ageL];
        [_generalGB addSubview:_ageNumL];
        
        
        
        [self.contentView addSubview:_commentIV];
        [self.contentView addSubview:_praiseBtn];
        [self.contentView addSubview:_collectBtn];
        [self.contentView addSubview:_commentBtn];
        [self.contentView addSubview:_chatBtn];
        
        UIFont *saleFont=[UIFont systemFontOfSize:12];
        self.isExpressL=[[UILabel alloc] init];
     
        self.priceL=[[UILabel alloc] init];
    
        self.saleStatusL=[[UILabel alloc] init];

  
        _saleStatusL.text=@"出售中";
        _saleStatusL.backgroundColor=[UIColor redColor];
        _saleStatusL.textColor=WHITEColor;
        _isExpressL.text=@"包邮";
        _isExpressL.font=saleFont;
        _priceL.font=saleFont;
        _priceL.textColor=[UIColor redColor];
        _priceL.layer.borderWidth=1;
        _priceL.layer.borderColor=RedColor.CGColor;
        _saleStatusL.font=saleFont;
        
        _heightL.text=@"高度";
        _heightNumL.text=@"38CM";
        _widthL.text=@"宽度";
        _widthNumL.text=@"20CM";
        _diameterL.text=@"直径";
        _diameterNumL.text=@"4CM";
        _ageL.text=@"盆龄";
        _ageNumL.text=@"10YEAR";
        
        _heightL.textAlignment=NSTextAlignmentCenter;
        _widthL.textAlignment=NSTextAlignmentCenter;
        _diameterL.textAlignment=NSTextAlignmentCenter;
        _ageL.textAlignment=NSTextAlignmentCenter;
        UIFont *font=[UIFont systemFontOfSize:15];
        _heightL.font=font;
        _heightNumL.font=font;
        _widthL.font=font;
        _widthNumL.font=font;
        
        _diameterL.font=font;
        _diameterNumL.font=font;
        _ageL.font=font;
        _ageNumL.font=font;
        
        UIColor *generalColor=[UIColor darkGrayColor];
        _heightL.textColor=generalColor;
        _heightNumL.textColor=generalColor;
        _widthL.textColor=generalColor;
        _widthNumL.textColor=generalColor;
        _diameterL.textColor=generalColor;
        _diameterNumL.textColor=generalColor;
        _ageL.textColor=generalColor;
        _ageNumL.textColor=generalColor;
        
        self.praiseView=[[PraiseView alloc] init];
        [self.contentView addSubview:_praiseView];
        self.bottomToolView=[[BottomToolView alloc] init];
        [self.contentView addSubview:_bottomToolView];
        self.bottomLine=[[UIView alloc] init];
        [self.contentView addSubview:_bottomLine];
        
        [self.contentView addSubview:_priceL];
        [self.contentView addSubview:_saleStatusL];
        [self.contentView addSubview:_isExpressL];
        _priceL.textAlignment=NSTextAlignmentCenter;
        _saleStatusL.textAlignment=NSTextAlignmentCenter;
        _isExpressL.textAlignment=NSTextAlignmentCenter;
        
        [_bottomToolView.praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomToolView.collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomToolView.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomToolView.commentBtn setUserInteractionEnabled:NO];
        [_bottomToolView.chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.height.offset(Top_Height);
    }];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(fenXiang_offX);
        make.top.equalTo(_topView.mas_top).offset(fenXiang_offX*2);

        make.width.and.height.offset(fenXiang_HeadSize);
        
    }];
    
    
//    _nickNameL.text=@"黑键";
    [_nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_right).offset(fenXiang_offX);
        make.top.equalTo(_topView.mas_top).offset(fenXiang_offX*2);
        
//        make.width.and.height.offset(fenXiang_HeadSize);
    }];
    [_memberIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickNameL.mas_right).offset(2);
        make.topMargin.equalTo(_nickNameL.mas_topMargin);
    }];
    [_memberIV sizeToFit];
    [_levelIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.equalTo(_nickNameL.mas_leftMargin);
//         make.left.equalTo(_headView.mas_right).offset(fenXiang_offX);
        make.top.equalTo(_nickNameL.mas_bottom).offset(3);
        
    }];
    [_levelIV sizeToFit];
//    [_timeL setText:@"02-10 19：00"];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
          make.leftMargin.equalTo(_nickNameL.mas_leftMargin);
        make.top.equalTo(_levelIV.mas_bottom).offset(3);
        
    }];
    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.width.offset(60);
        make.height.offset(30);
        make.top.offset(20);
        
    }];
    [_certificateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottomMargin.equalTo(_headView.mas_bottomMargin);
        make.rightMargin.equalTo(_headView.mas_rightMargin);
        
    }];
    [_certificateIV sizeToFit];
    [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(image_Size);
    }];
//    NSArray *array=[[NSArray alloc] initWithObjects:@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg",@"http://www.photo0086.com/member/751/pic/201204191650075075.JPG",@"http://image13-c.poco.cn/mypoco/myphoto/20121126/19/64947591201211261905061490497461183_000.jpg?1800x1500_120", nil];
//    _imageScrollView.contentSize
    for (UIView *temp in _imageScrollView.subviews) {
        if (temp.tag==100||temp.tag==101||temp.tag==102||temp.tag==103||temp.tag==104||temp.tag==105) {
            [temp removeFromSuperview];
        }
    }
    _imageScrollView.contentOffset=CGPointZero;
    _imageScrollView.contentSize=CGSizeMake(_info.Attach.count*image_Size+image_offX*_info.Attach.count, image_Size);
    WS(weakSelf)
    for (int i=0;i<_info.Attach.count;i++) {
        CustomImageView *imageView=[[CustomImageView alloc] init];
        [imageView setTapBlock:^(id sender){
            if ([weakSelf.delegate respondsToSelector:@selector(tapImageViewWithCellIndex:imageIndex:)]) {
                [weakSelf.delegate tapImageViewWithCellIndex:_indexPath imageIndex:imageView.index];
            }
        }];
        imageView.index=i;
        if (_isDetail) {
                [imageView addTapAction]; 
        }
        else{
            [imageView setUserInteractionEnabled:NO];
        }
   
        imageView.tag=100+i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_info.Attach[i]] placeholderImage:nil];
        [_imageScrollView addSubview:imageView];
        UIImageView *temp=[_imageScrollView viewWithTag:100+i-1];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.width.and.height.offset(image_Size);
            if (temp) {
                make.left.equalTo(temp.mas_right).offset(image_offX);
            }
            else{
                make.left.offset(0);
            }
        
        }];
    }
    
//    NSArray *tags=[[NSArray alloc] initWithObjects:@"柏",@"大树型号", nil];
    NSMutableArray *tags=[[NSMutableArray alloc] init];
    if (_info.Varieties.length) {
           [tags addObject:_info.Varieties];
    }
    if (_info.Model.length) {
        [tags addObject:_info.Model];
    }
    if (_info.Domestic.length) {
        [tags addObject:_info.Domestic];
    }
    if (_info.Origin.length) {
        [tags addObject:_info.Origin];
    }
    if (_info.Other.length) {
        [tags addObject:_info.Other];
    }
    if (_info.Size.length) {
        [tags addObject:_info.Size];
    }
    if (_info.Category.length) {
        [tags addObject:_info.Category];
    }
 
    for (UIView *temp in self.contentView.subviews) {
        if (temp.tag==200||temp.tag==201||temp.tag==202||temp.tag==203||temp.tag==204||temp.tag==205||temp.tag==206||temp.tag==207) {
            [temp removeFromSuperview];
        }
    }
    for (int i=0; i<tags.count; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.tag=200+i;
        label.text=tags[i];
        label.layer.cornerRadius=5;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = GRAYCOLOR.CGColor;
        label.clipsToBounds=YES;
        label.textAlignment=NSTextAlignmentCenter;
//        label.backgroundColor=[UIColor darkGrayColor];
        label.textColor=GRAYCOLOR;
        label.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        UILabel *temp=[self.contentView viewWithTag:200+i-1];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageScrollView.mas_bottom).offset(10);
            make.height.offset(20);
            if ([tags[i] length]>=3) {
                   make.width.offset(50);
            }
            else{
                 make.width.offset(40);
            }
         
            if (temp) {
                make.left.equalTo(temp.mas_right).offset(5);
            }
            else{
                make.left.offset(35);
            }
            
        }];
//        [label sizeToFit];
        
    }
    [_treeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(_imageScrollView.mas_bottom).offset(10);
        make.left.offset(10);
        
    }];
    [_treeIcon sizeToFit];
//    _descriptionL.text=@"刚才从日本买的。太喜欢啦、、、大手大脚阿里看见靠你了";
    float offX=10;
    if ([_info.InfoType integerValue]==2||[_info.InfoType integerValue]==3) {//出售
           offX=100;
    }
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-offX);
        make.height.offset(20);
        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
        
    }];
    
    
    [_descriptionL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
//        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
         make.top.equalTo(_titleL.mas_bottom).offset(10);
        
    }];
    [_descriptionL sizeToFit];
    [_generalGB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionL.mas_bottom).offset(5);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(50);
    }];
    [_h_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_generalGB.mas_centerY);
        make.height.offset(0.5);
        make.left.offset(0);
        make.right.offset(0);
        
    }];
    [_v_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_generalGB.mas_centerX);
        make.width.offset(0.5);
        make.top.offset(0);
        make.bottom.offset(0);
        
    }];
    
    [_heightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(2);
        make.width.offset(60);
        make.height.offset(20);
    }];
    [_widthL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(_h_line.mas_bottom).offset(1);
        make.width.offset(60);
        make.height.offset(20);
    }];
    [_v_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.equalTo(_heightL.mas_right).offset(1);
         make.width.offset(0.5);
        
    }];
    [_heightNumL mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.offset(2);
        make.left.equalTo(_v_line2.mas_right).offset(10);
        make.right.equalTo(_v_line.mas_left).offset(-1);
        make.height.offset(20);
        
    }];
    
    [_widthNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_h_line.mas_bottom).offset(1);
        make.left.equalTo(_v_line2.mas_right).offset(10);
        make.right.equalTo(_v_line.mas_left).offset(-1);
        make.height.offset(20);
        
    }];
    
    
    //直径
    
    [_diameterL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_v_line.mas_right).offset(1);
//        make.left.offset((SCREEN_WIDTH-20)/2);
//         make.left.equalTo(_heightNumL.mas_right).offset(3);
        make.top.offset(2);
        make.width.offset(60);
        make.height.offset(20);
    }];
    [_ageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_v_line.mas_right).offset(1);
//         make.left.offset((SCREEN_WIDTH-20)/2);
        make.top.equalTo(_h_line.mas_bottom).offset(1);
        make.width.offset(60);
        make.height.offset(20);
    }];
    
    [_v_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.equalTo(_diameterL.mas_right).offset(1);
        make.width.offset(0.5);
        
    }];
    
    [_diameterNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.left.equalTo(_v_line3.mas_right).offset(10);
        make.right.offset(-10);
//        make.right.equalTo(_generalGB.mas_left).offset(-1);//这句会导致约束报错
        make.height.offset(20);
//        make.width.offset(80);
        
    }];
//
    [_ageNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_h_line.mas_bottom).offset(1);
        make.left.equalTo(_v_line3.mas_right).offset(10);
        make.right.offset(-10);
        make.height.offset(20);
        
    }];
    
    
    [_praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(50);
        make.top.equalTo(_ageNumL.mas_bottom).offset(1);
    }];
//    [_praiseView initViewUsers:nil];
    [_praiseView initViewUsers:_info.Praised uid:_info.UID praiseNum:_info.PraisedNum];
    

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(0.5);
        make.top.equalTo(_praiseView.mas_bottom).offset(1);
    }];//
    _bottomLine.backgroundColor=Clear_Color;//线条暂时无用了 设置透明色
    

//    [_bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(0);
//        make.right.offset(0);
//        make.height.offset(BottomToolView_Height);
//        make.top.equalTo(_bottomLine.mas_bottom).offset(1);
//    }];
    
    
    if (self.isDetail) {//详情页面隐藏底部
        [_bottomToolView setHidden:YES];
    }
    float Width=50;
//    _priceL.text=@"100元";
//    if (self.enterType==2) {
        if ([_info.InfoType integerValue]==2) {//出售
            _saleStatusL.text=@"出售中";
            _priceL.text=[NSString stringWithFormat:@"%@元",[CommonFun delDecimal:_info.Price]];
        
            if ([_info.IsMailed boolValue]) {
               
                _isExpressL.backgroundColor=MIDDLEBLACK;
                _isExpressL.textColor=WHITEColor;
                _isExpressL.layer.borderWidth=1;
                _isExpressL.layer.borderColor=Clear_Color.CGColor;
                [_isExpressL setText:@"包邮"];
            
                if (_isDetail) {
                    [_isExpressL setHidden:NO];
                    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*2+10));
                        make.width.offset(Width);
                    }];
                    [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*1+10));
                        make.width.offset(Width);
                    }];
                    [_isExpressL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*0+10));
                        make.width.offset(Width);
                    }];
                }
                else{//列表页 不显示包邮
                    [_isExpressL setHidden:YES];
                    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*1+10));
                        make.width.offset(Width);
                    }];
                    [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*0+10));
                        make.width.offset(Width);
                    }];
//                    [_isExpressL mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
//                        make.right.offset(-(Width*0+10));
//                        make.width.offset(Width);
//                    }];
                }
            }
            else{
                [_isExpressL setHidden:YES];
                [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                    make.right.offset(-(Width*1+10));
                    make.width.offset(Width);
                }];
                [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                    make.right.offset(-(Width*0+10));
                    make.width.offset(Width);
                }];
//                [_isExpressL mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(_treeIcon.mas_bottom).offset(10);
//                    make.right.offset(-(Width*0+10));
//                    make.width.offset(Width);
//                }];
            }
            if (![_info.IsMarksPrice boolValue]) {
                [_priceL setText:@"不明价"];
//                _priceL.layer.borderWidth=1;
//                _priceL.layer.borderColor=RedColor.CGColor;
            }
            
        }
        else if ([_info.InfoType integerValue]==3) {//拍卖
                _saleStatusL.text=@"拍卖中";
            _priceL.text=[NSString stringWithFormat:@"%@元",[CommonFun delDecimal:_info.APrice]];
            if ([_info.IsMailed boolValue]) {
                
                [_isExpressL setText:@"包邮"];
                if (_isDetail) {
                    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*2+10));
                        make.width.offset(Width);
                    }];
                    [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*1+10));
                        make.width.offset(Width);
                    }];
                    [_isExpressL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*0+10));
                        make.width.offset(Width);
                    }];
                }
                else{
                    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*1+10));
                        make.width.offset(Width);
                    }];
                    [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                        make.right.offset(-(Width*0+10));
                        make.width.offset(Width);
                    }];
//                    [_isExpressL mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(_treeIcon.mas_bottom).offset(10);
//                        make.right.offset(-(Width*0+10));
//                        make.width.offset(Width);
//                    }];
                }
               

            }
            else{
                [_isExpressL setHidden:YES];
                [_isExpressL setHidden:YES];
                [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                    make.right.offset(-(Width*1+10));
                    make.width.offset(Width);
                }];
                [_saleStatusL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_treeIcon.mas_bottom).offset(10);
                    make.right.offset(-(Width*0+10));
                    make.width.offset(Width);
                }];
            }
        }
//    }
    
    for (UIView *temp in self.contentView.subviews) {
        if (temp.tag==501||[temp isMemberOfClass:[CommentLabel class]]) {
            [temp removeFromSuperview];
            
        }
    }
    //评论布局
    for (int i=0; i<_info.Comment.count; i++) {
        if (i==3&&!self.isDetail) {//列表页面只显示3条
            break;
        }
        UIView *lastView=[self.contentView viewWithTag:110+i-1];
        CommentInfo *comment=_info.Comment[i];
        float offX=10;
        float offY=5;
        if (i==0) {
            UIImageView *commentIV=[[UIImageView alloc] init];
            commentIV.tag=501;
            commentIV.image=[UIImage imageNamed:@"评论-列表"];
            [self.contentView addSubview:commentIV];
            
            [commentIV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(offX);
                //                make.top.offset(offY);
                if (!_isDetail) {
                    //                        make.top.equalTo(_bottomToolView.mas_bottom).offset(offY);
                    make.top.equalTo(_praiseView.mas_bottom).offset(offY);
                }
                else{
                    make.top.equalTo(_praiseView.mas_bottom).offset(offY);
                }
                
                make.width.and.height.offset(15);
            }];
        }
        
        CommentLabel *commentL=[[CommentLabel alloc] init];
        commentL.tag=110+i;
        commentL.text=[NSString stringWithFormat:@"%@: %@",comment.NickName,comment.Message];
        //        commentL.text=comment.Message;
        commentL.font=[UIFont systemFontOfSize:comment_FontSize];
        commentL.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:commentL];
        if (!lastView) {
            [commentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15+offX*2);
                make.right.offset(-offX);
                if (!_isDetail) {
                    //                  make.top.equalTo(_bottomToolView.mas_bottom).offset(offY);
                    make.top.equalTo(_praiseView.mas_bottom).offset(offY);
                }
                else{
                    make.top.equalTo(_praiseView.mas_bottom).offset(offY);
                }
            }];
        }
        else{
            [commentL mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15+offX*2);
                make.right.offset(-offX);
                make.top.equalTo(lastView.mas_bottom).offset(5);
            }];
        }
        
        [commentL sizeToFit];
        //底部工具条布局
        if (!_isDetail) {
            float offY=5;
            if (i==_info.Comment.count-1&&_info.Comment.count<=3) {
                [_bottomToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                    make.right.offset(0);
                    make.height.offset(BottomToolView_Height);
//                    make.top.equalTo(commentL.mas_bottom).offset(offY);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
                }];
                
            }
            else if(i==2&&_info.Comment.count>3){//大于3条评论
                [_bottomToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                    make.right.offset(0);
                    make.height.offset(BottomToolView_Height);
//                    make.top.equalTo(commentL.mas_bottom).offset(offY);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
                }];
                
            }
        }
        
        
    }
    //无评论时布局
    if (_info.Comment.count==0) {
        [_bottomToolView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(BottomToolView_Height);
//            make.top.equalTo(_praiseView.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
    }
    if ([_info.UID isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {
        [_attentBtn setHidden:YES];
        [_bottomToolView.chatBtn setEnabled:NO];
    }
    else{
        [_attentBtn setHidden:NO];
        [_bottomToolView.chatBtn setEnabled:YES];
    }
    _bottomToolView.isdetail=_isDetail;

    
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
    [_headView sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:Default_Image];
    _nickNameL.text=info.userInfo.NickName;
    _descriptionL.text=info.Descript;
    
    _heightNumL.text=[NSString stringWithFormat:@"%@CM",info.Height];
    _diameterNumL.text=[NSString stringWithFormat:@"%@CM",info.Diameter];
    _widthNumL.text=[NSString stringWithFormat:@"%@CM",info.Width];
    _ageNumL.text=[NSString stringWithFormat:@"%@YEAR",info.Old];

    _titleL.text=info.Title;
//    _timeL.text=[CommonFun translateDateWithCreateTime:[info.CreateTime integerValue]];
       _timeL.text=info.Createtime;
//    NSLog(@"info.CreateTime:%@",info.Createtime);
    if ([_info.userInfo.IsFocus boolValue]) {
        [_attentBtn setTitle:@"已关注" forState:UIControlStateNormal];
//        [_attentBtn setUserInteractionEnabled:NO];
    }
    else{
        [_attentBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_attentBtn setUserInteractionEnabled:YES];
    }
    _levelIV.image=[UIImage imageNamed:[NSString stringWithFormat:@"lv%@",info.userInfo.Levels]];//lv1
    if ([info.IsCollect boolValue]) {
           [_bottomToolView.collectBtn setImage:[UIImage imageNamed:@"收藏（已点）"] forState:UIControlStateNormal];
    }
    else {
           [_bottomToolView.collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    }
    if ([info.IsPraise boolValue]) {
          [_bottomToolView.praiseBtn setImage:[UIImage imageNamed:@"看好(已点)"] forState:UIControlStateNormal];
       
    }
    else{
        [_bottomToolView.praiseBtn setImage:[UIImage imageNamed:@"看好(未点)"] forState:UIControlStateNormal];
    }
   
    if ([_info.userInfo.RoleType isEqualToString:@"1"]||[_info.userInfo.RoleType isEqualToString:@"2"]) {
        
    }
    else{//未开通
        [_memberIV setHidden:YES];
    }
    if (![_info.userInfo.IsCertifi boolValue]) {
        [_certificateIV setHidden:YES];
    }
    
}
//点击头像
-(void)headAction{
    if (_clickBlock) {
        _clickBlock(nil);
    }
}


-(void)praiseAction:(UIButton*)sender{
    if (_praiseBlock) {
        _praiseBlock(nil);
    }
}

-(void)collectAction:(UIButton*)sender{
    if (_collectBlock) {
        _collectBlock(nil);
    }
}


-(void)commentAction:(UIButton*)sender{
    if (_commentBlock) {
        _commentBlock(_indexPath);
    }
}


-(void)chatAction:(UIButton*)sender{
    if (_chatBlock) {
        _chatBlock(nil);
    }
    
}

-(void)attentionAction:(UIButton*)sender{
    if (_attentionBlock) {
        _attentionBlock(nil);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view{
//    return NO;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
////    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIScrollView"]) {
//        return NO;
//    }
//    return  YES;
//}

-(void)tapScrollView:(UITapGestureRecognizer*)sender{
    if ([_delegate respondsToSelector:@selector(gotoDetailView:)]) {
        [_delegate gotoDetailView:_indexPath];
    }
    
}




@end

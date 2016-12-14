//
//  TuoGuanDetailTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/4/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "TCTuoGuanDetailTableViewCell.h"

@implementation TCTuoGuanDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *font=[UIFont systemFontOfSize:13];
        self.headIV=[[UIImageView alloc] init];
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
        
        self.contactL=[[UILabel alloc] init];
        self.phoneL=[[UILabel alloc] init];
        
        [self.contentView addSubview:_headIV];
        [self.contentView addSubview:_nameL];
        [self.contentView addSubview:_timeL];
        [self.contentView addSubview:_titleL];
        [self.contentView addSubview:_contentL];
        [self.contentView addSubview:_addressL];
        [self.contentView addSubview:_createTimeL];
        [self.contentView addSubview:_contactL];
        [self.contentView addSubview:_phoneL];
        [self.contentView addSubview:_priceL];
        
        [_timeL setTextColor:MIDDLEBLACK];
        [_priceL setTextColor:MIDDLEBLACK];
        [_addressL setTextColor:MIDDLEBLACK];
        [_titleL setTextColor:DEEPBLACK];
        [_contentL setTextColor:MIDDLEBLACK];
        [_contactL setTextColor:MIDDLEBLACK];
        [_phoneL setTextColor:MIDDLEBLACK];
        
        _titleL.font=[UIFont systemFontOfSize:16];
        _contentL.font=[UIFont systemFontOfSize:content_FontSize_TuoGuanDetail];
        _timeL.font=font;
        _priceL.font=font;
        _joinNumL.font=font;
        _addressL.font=font;
        _contactL.font=font;
        _phoneL.font=font;
        self.imagePlayerView= [[ImagePlayerView alloc] init];
        _imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
        [_imagePlayerView stopTimer];
        _imagePlayerView.imagePlayerViewDelegate=self;
        [self.contentView addSubview:_imagePlayerView];
        self.attentionBtn=[[UIButton alloc] init];
        [self.contentView addSubview:_attentionBtn];
        [_attentionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        _attentionBtn.layer.cornerRadius=3;
        _attentionBtn.clipsToBounds=YES;
        _attentionBtn.layer.borderWidth=0.5;
        _attentionBtn.layer.borderColor=Line_Color.CGColor;
        [_attentionBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.titleLabel.font=font;
        [_attentionBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
        self.praiseView=[[PraiseView alloc] init];
        [self.contentView addSubview:_praiseView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //       _titleL.text=@"第二届亚太盆景展览";
    //     _timeL.text=@"2016年2月10日-20日";
    //    _addressL.text=@"杭州市西湖大草坪";
    //        _priceL.text=@"费用: 50元/人";
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
    
    [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-offX);
        make.width.offset(60);
        make.top.offset(offY);
        make.height.offset(30);
    }];
    
    //    [_viewL mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.offset(-5);
    //        make.top.offset(10);
    //    }];
    //    [_praiseL mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.offset(-5);
    //        make.top.equalTo(_viewL.mas_bottom).offset(1);
    //    }];
    
    [_imagePlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIV.mas_bottom).offset(5);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(Tree_Height_SameCity);
    }];
    //    NSString *url=@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg";
    //    [_treeIV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    //    _treeIV.backgroundColor=[UIColor greenColor];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        //        make.right.offset(-100);
        make.height.offset(20);
        make.top.equalTo(_imagePlayerView.mas_bottom).offset(offY);
    }];
    
    
    
    //    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.offset(offX);
    //        //        make.right.offset(-100);
    //        make.height.offset(20);
    //        make.top.equalTo(_contentL.mas_bottom).offset(0);
    //    }];
    
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.height.offset(20);
        make.top.equalTo(_titleL.mas_bottom).offset(5);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.height.offset(20);
        make.top.equalTo(_addressL.mas_bottom).offset(0);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.height.offset(20);
        make.top.equalTo(_contactL.mas_bottom).offset(0);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.right.offset(-offX);
        make.top.equalTo(_phoneL.mas_bottom).offset(0);
    }];
    _contentL.numberOfLines=0;
    [_contentL sizeToFit];
    
    [_praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(50);
        make.top.equalTo(_contentL.mas_bottom).offset(1);
    }];
    [_praiseView initViewUsers:_info.Praised uid:_info.UID praiseNum:_info.PraisedNum];
    _praiseView.praiseL.text=@"想去";
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-offX);
        //        make.right.offset(-100);
        make.height.offset(20);
        make.top.equalTo(_titleL.mas_top).offset(0);
    }];
    
    
    //    [_joinNumL mas_makeConstraints:^(MASConstraintMaker *make) {
    //        //        make.left.offset(offX);
    //        make.right.offset(-offX);
    //        make.top.equalTo(_treeIV.mas_bottom).offset(offY);
    //    }];
}

-(void)setInfo:(ActivityInfo*)info{
    _info=info;
    //    ActivityInfo *temp=[[ActivityInfo alloc] init];
    //    _info=temp;
    //    NSMutableArray *_imageUrls=[[NSMutableArray alloc] init];
    //    [_imageUrls addObject:@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg"];
    //    [_imageUrls addObject:@"http://www.photo0086.com/member/751/pic/201204191650075075.JPG"];
    //    [_imageUrls addObject:@"http://image13-c.poco.cn/mypoco/myphoto/20121126/19/64947591201211261905061490497461183_000.jpg?1800x1500_120"];
    //    _info.Attach=_imageUrls;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:Default_Image];
    _titleL.text=info.Title;
    _contentL.text=info.Message;
    _createTimeL.text=info.CreateTime;
    _nameL.text=info.userInfo.NickName;
    
    //    NSString *url=info.Attach[0];
    //    [_treeIV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    _timeL.text=@"2016年2月10日-20日";
    //    _addressL.text=@"地址:杭州市西湖区孤山";
    _addressL.text=[NSString stringWithFormat:@"地址:%@",info.Address];
    _contactL.text=[NSString stringWithFormat:@"联系人:%@",info.Contact];
    _phoneL.text=[NSString stringWithFormat:@"电话:%@",info.Mobile];
    [_imagePlayerView reloadData];
    if ([_info.userInfo.IsFocus boolValue]) {
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
//        [_attentionBtn setUserInteractionEnabled:NO];
    }
    else{
        [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_attentionBtn setUserInteractionEnabled:YES];
    }
    _priceL.text=[NSString stringWithFormat:@"价格:%@",info.Cost?info.Cost:@"暂无"];
 
}

- (NSInteger)numberOfItems
{
    return _info.Attach.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_info.Attach objectAtIndex:index]]];
    //              placeholderImage:[UIImage imageNamed:@"Default_course"]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
        for (int i=0;i<_info.Attach.count;i++) {
            [temp addObject:[MWPhoto photoWithURL:[NSURL URLWithString:_info.Attach[i]]]];
        }
    
        self.photos=temp;
        [self showBrowserWithIndex:index];
}


-(void)showBrowserWithIndex:(NSInteger)index{
    
    //    self.thumbs = thumbs;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:index];
    UIViewController *nav=[CommonFun viewControllerHasNavigation:self];
    
    [nav.navigationController pushViewController:browser animated:YES];
}




- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}



-(void)dealloc{
    _imagePlayerView.imagePlayerViewDelegate=nil;
}

-(void)attentionAction{
    if (_attentionBlock) {
        _attentionBlock(nil);
    }
}

@end

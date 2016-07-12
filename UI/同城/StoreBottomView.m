//
//  StoreBottomView.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/6.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  同城 店家底部视图

#import "StoreBottomView.h"

@implementation StoreBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    float offY=10;
    float offX=10;
    float width=60;
    float height=40;
    self.viewBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*4-offX*4, offY, width, height)];
        self.praiseBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*3-offX*3, offY, width, height)];
    self.collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*2-offX*2, offY, width, height)];
    self.commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*1-offX*1, offY, width, height)];

    [self addSubview:_viewBtn];
    [self addSubview:_collectBtn];
    [self addSubview:_commentBtn];
    [self addSubview:_praiseBtn];
    [_viewBtn setImage:[UIImage imageNamed:@"tc_阅读"] forState:UIControlStateNormal];
    //    [_collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"tc_评论icon"] forState:UIControlStateNormal];
    
//    [_praiseBtn setImage:[UIImage imageNamed:@"tc_赞(未点)"] forState:UIControlStateNormal];
    //tc_赞(未点)   tc_赞(已点)
    
    UIFont *font=[UIFont systemFontOfSize:12];
    _viewBtn.titleLabel.font=font;
    _commentBtn.titleLabel.font=font;
    _praiseBtn.titleLabel.font=font;
    _collectBtn.titleLabel.font=font;
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.5)];
    [self addSubview:line];
    line.backgroundColor=Line_Color;
    [_viewBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_commentBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_praiseBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_collectBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    
    [_commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [_praiseBtn addTarget:self action:@selector(praiseAction) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    
}

//评论
-(void)commentAction{
    if (_commentBlock) {
        _commentBlock(nil);
    }
}

//赞
-(void)praiseAction{
    if (_praiseBlock) {
        _praiseBlock(nil);
    }
}

//收藏
-(void)collectAction{
    if (_collectBlock) {
        _collectBlock(nil);
    }
    
}

//刷新数目
-(void)refreshUI{
    [_viewBtn setTitle:[NSString stringWithFormat:@" %@",_info.BrowseNum] forState:UIControlStateNormal];
    [_commentBtn setTitle:[NSString stringWithFormat:@" %@",_info.CommentsNum] forState:UIControlStateNormal];
    //    [_joinBtn setTitle:_info.JoinNum forState:UIControlStateNormal];
    [_collectBtn setTitle:[NSString stringWithFormat:@" %@",_info.CollectionNum] forState:UIControlStateNormal];
    
    [_praiseBtn setTitle:[NSString stringWithFormat:@" %@",_info.PraisedNum] forState:UIControlStateNormal];
    //    [_commentBtn setTitle:@"100" forState:UIControlStateNormal];
    if ([_info.IsPraise boolValue]) {
//        [_praiseBtn setTitle:@"已参加" forState:UIControlStateNormal];
//        [_praiseBtn setUserInteractionEnabled:NO];
        [_praiseBtn setImage:[UIImage imageNamed:@"tc_赞(已点)"] forState:UIControlStateNormal];
        
    }
    else{
        [_praiseBtn setImage:[UIImage imageNamed:@"tc_赞(未点)"] forState:UIControlStateNormal];
    }
    if ([_info.IsCollect boolValue]) {
        [_collectBtn setImage:[UIImage imageNamed:@"tc_收藏（选中）"] forState:UIControlStateNormal];
        //        [_collectBtn setUserInteractionEnabled:NO];
    }
    else{
        [_collectBtn setImage:[UIImage imageNamed:@"tc_收藏（未点）"] forState:UIControlStateNormal];
    }
    
}

-(void)setInfo:(ActivityInfo *)info{
    _info=info;
    [self refreshUI];
}



@end

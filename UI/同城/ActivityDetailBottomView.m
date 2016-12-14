//
//  ActivityDetailBottomView.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/6.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityDetailBottomView.h"

@implementation ActivityDetailBottomView

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
    self.collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*3-offX*3, offY, width, height)];
    self.commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width*2-offX*2, offY, width, height)];
    self.joinBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width-offX, offY, width, height)];
    [self addSubview:_viewBtn];
    [self addSubview:_collectBtn];
    [self addSubview:_commentBtn];
    [self addSubview:_joinBtn];
    [_viewBtn setImage:[UIImage imageNamed:@"tc_阅读"] forState:UIControlStateNormal];
//    [_collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"tc_评论icon"] forState:UIControlStateNormal];
    
    [_joinBtn setImage:[UIImage imageNamed:@"参加"] forState:UIControlStateNormal];
    //tc_赞(未点)   tc_赞(已点)
   
    UIFont *font=[UIFont systemFontOfSize:12];
    _viewBtn.titleLabel.font=font;
    _commentBtn.titleLabel.font=font;
    _joinBtn.titleLabel.font=font;
    _collectBtn.titleLabel.font=font;
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.5)];
    [self addSubview:line];
    line.backgroundColor=Line_Color;
    [_viewBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_commentBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_joinBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_collectBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    
    [_commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [_joinBtn addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    
}

//评论
-(void)commentAction{
    if (_commentBlock) {
        _commentBlock(nil);
    }
}

//参加
-(void)joinAction{
    if (_joinBlock) {
        _joinBlock(nil);
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
    
//    [_commentBtn setTitle:@"100" forState:UIControlStateNormal];
    if ([_info.isJoin boolValue]) {
        [_joinBtn setTitle:@"已参加" forState:UIControlStateNormal];
//        [_joinBtn setUserInteractionEnabled:NO];
    }
    else{
        [_joinBtn setTitle:@"参加" forState:UIControlStateNormal];
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

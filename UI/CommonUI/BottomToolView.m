//
//  BottomToolView.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BottomToolView.h"

@implementation BottomToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self=[super init];
    if (self) {
        [self initView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initView{
    float offX=10;
    float offY=5;
    float width=70;
    float offX2=(SCREEN_WIDTH-offX*2-width*4)/4;
    UIFont *font=[UIFont systemFontOfSize:13];
    UIColor *textColor=GRAYCOLOR;
    self.praiseBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX, offY, width, 40)];
    [_praiseBtn setImage:[UIImage imageNamed:@"看好(未点)"] forState:UIControlStateNormal];
    [_praiseBtn setTitleColor:textColor forState:UIControlStateNormal];
    _praiseBtn.titleLabel.font=font;
    [_praiseBtn setTitle:@"看好" forState:UIControlStateNormal];
//    [_praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2+width, offY, width, 40)];
//    [_collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn setTitleColor:textColor forState:UIControlStateNormal];
    _collectBtn.titleLabel.font=font;
    [_collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    UIButton *commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*2+width*2, offY, width, 40)];
//    [commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitleColor:textColor forState:UIControlStateNormal];
    commentBtn.titleLabel.font=font;
    [commentBtn setImage:[UIImage imageNamed:@"评论icon"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    self.commentBtn=commentBtn;
    //
    UIButton *chatBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*3+width*3, offY, width, 40)];
//    [chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn setTitleColor:textColor forState:UIControlStateNormal];
    chatBtn.titleLabel.font=font;
    [chatBtn setTitle:@"私信" forState:UIControlStateNormal];
    [chatBtn setImage:[UIImage imageNamed:@"私信"] forState:UIControlStateNormal];
    self.chatBtn=chatBtn;
    //
    [self addSubview:_praiseBtn];
    [self addSubview:_collectBtn];
    [self addSubview:_commentBtn];
    [self addSubview:chatBtn];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, BottomToolView_Height-0.5, SCREEN_WIDTH, 0.5)];
    [self addSubview:line];
    line.backgroundColor=Line_Color;
}



-(void)praiseAction:(UIButton*)sender{
    
}

-(void)collectAction:(UIButton*)sender{
    
}


-(void)commentAction:(UIButton*)sender{
    
}


-(void)chatAction:(UIButton*)sender{
    
}


@end

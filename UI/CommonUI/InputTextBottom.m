//
//  InputTextBottom.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "InputTextBottom.h"

@implementation InputTextBottom
static float bottom_Height=50;
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
        float offY=10;
        float offX=10;
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        [line setBackgroundColor:Line_Color];
        self.inputText=[[UITextField alloc] initWithFrame:CGRectMake(10, offY, SCREEN_WIDTH-offX*2-55, bottom_Height-offY*2)];
        [self addSubview:_inputText];
        _inputText.placeholder=@"请输入评论内容";
        self.sendBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, offY, 60, 30)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _sendBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_sendBtn];
        [self addSubview:line];
        
    }
    return self;
}



@end

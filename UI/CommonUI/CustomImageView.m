//
//  CustomImageView.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addTapAction{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTapAction:)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
//    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [btn setUserInteractionEnabled:YES];
//    btn.backgroundColor=Clear_Color;
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addTapAction:(UITapGestureRecognizer*)tap{
    if (_tapBlock) {
        _tapBlock([NSNumber numberWithInteger:_index]);
    }
  
    
}

-(void)tapAction{
    if (_tapBlock) {
        _tapBlock([NSNumber numberWithInteger:_index]);
    }
}


-(id)init{
    self=[super init];
    if (self) {
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
//        [self addTapAction];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
        [self addTapAction];
    }
    return self;
    
}

@end

//
//  PraiseView.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "PraiseView.h"
#import "YPUserInfo.h"
@implementation PraiseView
static CGFloat image_Width=30;
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
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)initViewUsers:(NSMutableArray*)users uid:(NSString*)uid praiseNum:(NSString*)praiseNum{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
//    UIButton *praiseBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, image_Width, image_Width)];
    UILabel *praiseL=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 16)];
    praiseL.font=[UIFont systemFontOfSize:12];
    praiseL.textColor=[UIColor darkGrayColor];
    [self addSubview:praiseL];
    self.praiseL=praiseL;
    praiseL.text=@"看好";
    praiseL.textAlignment=NSTextAlignmentCenter;
    UILabel *praiseNumL=[[UILabel alloc] initWithFrame:CGRectMake(10, 26, 40, 18)];
    praiseNumL.font=[UIFont systemFontOfSize:12];
    praiseNumL.textColor=[UIColor darkGrayColor];
    [self addSubview:praiseNumL];
     praiseNumL.textAlignment=NSTextAlignmentCenter;
//    praiseNumL.text=@"10";
    praiseNumL.text=[NSString stringWithFormat:@"%d",users.count];

//    [praiseBtn setBackgroundImage:[UIImage imageNamed:@"点赞-列表"] forState:UIControlStateNormal];
//    [self addSubview:praiseBtn];
    for (int i=0; i<users.count; i++) {
        YPUserInfo *info=users[i];
        UIImageView *userIV=[[UIImageView alloc] initWithFrame:CGRectMake(10+40+10*i+image_Width*i, 10, image_Width, image_Width)];
        userIV.layer.cornerRadius=15;
        userIV.clipsToBounds=YES;
        [self addSubview:userIV];
//        if (i==0) {
//            userIV.image=[UIImage imageNamed:@"点赞-列表"];
//        }
//        else if(i==5){
//            
//        }
//        else{
//            userIV.image=[UIImage imageNamed:@"tree"];
        [userIV sd_setImageWithURL:[NSURL URLWithString:info.UserHeader] placeholderImage:Default_Image];
        
    }
    NSInteger count=users.count-1;
    if ([praiseNum integerValue]>6) {
        UIButton *moreBtn=[[UIButton alloc] initWithFrame:CGRectMake(10+40+10*count+image_Width*count, 10, 100, image_Width)];
        [moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        moreBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        //    moreBtn.backgroundColor=BLACKCOLOR;
        [self addSubview:moreBtn];
    }
   
    
}

@end

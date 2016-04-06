//
//  OfferPriceView.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/9.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  出价

#import "OfferPriceView.h"

@implementation OfferPriceView

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
//        [self initView];
    }
    return self;
}

-(void)initViewWithPrice:(NSString*)price{
    float offX=15;
    float height=200;
    float offY=150;
    bgView=[[UIView alloc] initWithFrame:CGRectMake(offX, offY, SCREEN_WIDTH-offX*2, height)];
    bgView.layer.cornerRadius=5;
    bgView.clipsToBounds=YES;
//    [bgView setUserInteractionEnabled:NO];
    [bgView setBackgroundColor:WHITEColor];
    [self addSubview:bgView];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [bgView addGestureRecognizer:tap2];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewAction)];
    [self addGestureRecognizer:tap];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, bgView.frame.size.width, 20)];
    label1.text=@"出价";
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+10, bgView.frame.size.width, 20)];
    label2.textColor=[UIColor grayColor];
//    label2.text=@"当前最高出价：¥100";
    label2.text=[NSString stringWithFormat:@"当前最高出价：¥%@",price];
    label2.font=[UIFont systemFontOfSize:14];
    label1.textAlignment=NSTextAlignmentCenter;
    label2.textAlignment=NSTextAlignmentCenter;
     priceTF=[[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2.frame)+15, bgView.frame.size.width-15*2, 35)];
    priceTF.borderStyle=UITextBorderStyleRoundedRect;
    priceTF.placeholder=@"请输入您的出价";
    priceTF.keyboardType=UIKeyboardTypeNumberPad;
    [priceTF becomeFirstResponder];
    
    UIButton *surePrice=[[UIButton alloc] initWithFrame:CGRectMake(priceTF.frame.origin.x, CGRectGetMaxY(priceTF.frame)+5, priceTF.frame.size.width, 35)];
    surePrice.layer.cornerRadius=5;
    surePrice.clipsToBounds=YES;
    [surePrice setTitleColor:WHITEColor forState:UIControlStateNormal];
    [surePrice setTitle:@"出价" forState:UIControlStateNormal];
    [surePrice setBackgroundColor:[UIColor redColor]];
    [surePrice addTarget:self action:@selector(surePriceAction) forControlEvents:UIControlEventTouchUpInside];
    
    float btn_height=38;
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(surePrice.frame)+10, bgView.frame.size.width/2, btn_height)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIButton *addPriceBtn=[[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, CGRectGetMaxY(surePrice.frame)+10, bgView.frame.size.width/2, btn_height)];
    [addPriceBtn addTarget:self action:@selector(addPriceAction) forControlEvents:UIControlEventTouchUpInside];
    [addPriceBtn setTitle:@"加一手" forState:UIControlStateNormal];
    [addPriceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.origin.y, bgView.frame.size.width, 0.5)];
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, cancelBtn.frame.origin.y, 0.5, btn_height)];
    line1.backgroundColor=Line_Color;
    line2.backgroundColor=Line_Color;
    [cancelBtn addTarget:self action:@selector(removeViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:label1];
    [bgView addSubview:label2];
    [bgView addSubview:priceTF];
    [bgView addSubview:surePrice];
    [bgView addSubview:cancelBtn];
    [bgView addSubview:addPriceBtn];
    [bgView addSubview:line1];
    [bgView addSubview:line2];
    
//    for (UIView *subView in bgView.subviews) {
//        [subView setUserInteractionEnabled:YES];
//    }
}

-(void)tap2Action{
    
}
-(void)removeViewAction{
    [UIView animateKeyframesWithDuration:0.2 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//出价
-(void)surePriceAction{
    if (_offerPriceBlock) {
        _offerPriceBlock(priceTF.text);
    }
}

//加价
-(void)addPriceAction{
  
    NSString *msg=[NSString stringWithFormat:@"是否加一手加价%@ ¥",_MakeUp];
    [UIAlertView bk_showAlertViewWithTitle:nil message:msg cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            if (_addPriceBlock) {
                _addPriceBlock(nil);
            }
        }
        
    }];
    
}
@end

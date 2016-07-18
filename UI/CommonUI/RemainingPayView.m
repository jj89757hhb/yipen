//
//  RemainingPayView.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  余额支付

#import "RemainingPayView.h"

@implementation RemainingPayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)initViewWithPrice:(NSString*)price{
    float offX=15;
    float height=(200-40);
    float offY=150;
    // (SCREEN_HEIGHT-height)/2
    bgView=[[UIView alloc] initWithFrame:CGRectMake(offX,offY, SCREEN_WIDTH-offX*2, height)];
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
        label1.text=@"使用余额支付";
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame)+10, bgView.frame.size.width, 20)];
    label2.textColor=[UIColor grayColor];
    //    label2.text=@"对方报价：¥100";
    label2.text=[NSString stringWithFormat:@"支付：¥%@ 余额：¥0",price];
    label2.font=[UIFont systemFontOfSize:14];
    label1.textAlignment=NSTextAlignmentCenter;
    label2.textAlignment=NSTextAlignmentCenter;
    
//    UILabel *label3=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+5, bgView.frame.size.width, 20)];
//    label3.textColor=[UIColor grayColor];
//    if (isNegotiate) {
//        label3.text=@"(仅一次议价机会)";
//    }
//    else{
//        label3.text=@"(仅一次回价机会)";
//    }
//    label3.font=[UIFont systemFontOfSize:12];
//    label3.textAlignment=NSTextAlignmentCenter;
//    label3.textAlignment=NSTextAlignmentCenter;
    
    
    pswTF=[[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2.frame)+15, bgView.frame.size.width-15*2, 35)];
    pswTF.borderStyle=UITextBorderStyleRoundedRect;
        pswTF.placeholder=@"请输入支付密码（6位数）";
    pswTF.keyboardType=UIKeyboardTypeNumberPad;
    pswTF.secureTextEntry=YES;
    [pswTF becomeFirstResponder];
    
    //    UIButton *surePrice=[[UIButton alloc] initWithFrame:CGRectMake(priceTF.frame.origin.x, CGRectGetMaxY(priceTF.frame)+5, priceTF.frame.size.width, 35)];
    //    surePrice.layer.cornerRadius=5;
    //    surePrice.clipsToBounds=YES;
    //    [surePrice setTitleColor:WHITEColor forState:UIControlStateNormal];
    //    [surePrice setTitle:@"出价" forState:UIControlStateNormal];
    //    [surePrice setBackgroundColor:[UIColor redColor]];
    //    [surePrice addTarget:self action:@selector(surePriceAction) forControlEvents:UIControlEventTouchUpInside];
    
    float btn_height=38;
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pswTF.frame)+10, bgView.frame.size.width/2, btn_height)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIButton *addPriceBtn=[[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, CGRectGetMaxY(pswTF.frame)+10, bgView.frame.size.width/2, btn_height)];
    [addPriceBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [addPriceBtn setTitle:@"确定" forState:UIControlStateNormal];
    [addPriceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    UIView *line1=[[UIView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.origin.y, bgView.frame.size.width, 0.5)];
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, cancelBtn.frame.origin.y, 0.5, btn_height)];
    line1.backgroundColor=Line_Color;
    line2.backgroundColor=Line_Color;
    [cancelBtn addTarget:self action:@selector(removeViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:label1];
    [bgView addSubview:label2];
//    [bgView addSubview:label3];
    [bgView addSubview:pswTF];
    
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


//支付
-(void)payAction{
    if (pswTF.text.length!=6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位正确的支付密码"];
        return;
    }
    if (_payBlock) {
        _payBlock(pswTF.text);
    }
    
}



@end

//
//  NegotiatePriceView.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NegotiatePriceBlock)(id sender);//出价
@interface NegotiatePriceView : UIView{
    UIView *bgView;
    UITextField *priceTF;
}
@property (nonatomic,copy) NegotiatePriceBlock negotiatePriceBlock;
-(void)initViewWithPrice:(NSString*)price isNegotiate:(BOOL)isNegotiate;
@end

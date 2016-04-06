//
//  OfferPriceView.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/9.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OfferPriceBlock)(id sender);//出价
typedef void(^AddPriceBlock)(id sender);//加一手
@interface OfferPriceView : UIView{
    UIView *bgView;
    UITextField *priceTF;
}
@property (nonatomic,copy) OfferPriceBlock offerPriceBlock;
@property (nonatomic,copy) AddPriceBlock addPriceBlock;
//@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *MakeUp;//加价；
-(void)initViewWithPrice:(NSString*)price;
@end

//
//  BuyView.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
static float buyView_Height=45;
@interface BuyView : UIView
@property(nonatomic,strong)UIButton *negotiateBtn;//议价
@property(nonatomic,strong)UIButton *buyBtn;
@property(nonatomic,strong)UIButton *askPriceBtn;//询价
@property(nonatomic,assign)NSInteger enterType;//0议价 1 询价
@end

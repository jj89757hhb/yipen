//
//  AppPurchase.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/30.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
@interface AppPurchase : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (strong, nonatomic) NSArray* products;
@property(strong,nonatomic)SKProduct *product;
@property(nonatomic,assign)Pay_Type_Weixin memberType;//会员类型
+(AppPurchase*)sharedAppPurchase;
-(void)requestProducts;
-(void)willPurchase;
-(void)removeTransaction;

@end

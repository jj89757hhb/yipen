//
//  ExchangeInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/7/11.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  交易助手

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
#import "PenJinInfo.h"
@interface ExchangeInfo : NSObject
@property(nonatomic,strong)NSString *AuctionStatus;
@property(nonatomic,strong)NSString *BID;//盆景id
@property(nonatomic,strong)NSString *BuyerID;
@property(nonatomic,strong)NSString *CreateTime;
@property(nonatomic,strong)NSString *IsMark;
@property(nonatomic,strong)NSString *NAmount;//价格
@property(nonatomic,strong)NSString *Phase;
//@property(nonatomic,strong)NSString *Result;
@property(nonatomic,assign)Buy_Result Result;
@property(nonatomic,strong)NSString *SalerID;
@property(nonatomic,strong)NSString *TranNo;
@property(nonatomic,strong)NSString *Type;
@property(nonatomic,strong)YPUserInfo *BuyUser;//买家
@property(nonatomic,strong)YPUserInfo *SaleUser;//卖家
@property(nonatomic,strong)PenJinInfo *Bonsai;//盆景
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

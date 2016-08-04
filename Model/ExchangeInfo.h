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
@property(nonatomic,strong)NSString *Createtime;//晕！！交易中又变成了这个
@property(nonatomic,strong)NSString *IsMark;
@property(nonatomic,strong)NSString *NAmount;//价格
@property(nonatomic,strong)NSString *Phase;
//@property(nonatomic,strong)NSString *Result;
@property(nonatomic,assign)Buy_Result Result;
@property(nonatomic,strong)NSString *SalerID;
@property(nonatomic,strong)NSString *TranNo;
@property(nonatomic,strong)NSString *Type;
@property(nonatomic,strong)NSString *OldAmount;//原价
@property(nonatomic,strong)YPUserInfo *BuyUser;//买家
@property(nonatomic,strong)YPUserInfo *SaleUser;//卖家
@property(nonatomic,strong)PenJinInfo *Bonsai;//盆景
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *Contacter;
@property(nonatomic,strong)NSMutableArray *BDetails;//议价过程数组

//交易：我买、我卖的使用
@property(nonatomic,strong)NSString *AlipayRet;
@property(nonatomic,strong)NSString *WeChatRet;
@property(nonatomic,assign)Order_Status Status;
@property(nonatomic,strong)NSString *TradingNo;
@property(nonatomic,strong)NSString *DealPrice;
@property(nonatomic,strong)NSString *DealSource;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Courier;//快递
@property(nonatomic,strong)NSString *CourierNo;//快递单号
@property(nonatomic,strong)NSString *PayType;

- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

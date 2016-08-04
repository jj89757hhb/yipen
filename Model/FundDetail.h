//
//  FundDetail.h
//  panjing
//
//  Created by 华斌 胡 on 16/7/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FundDetail : NSObject{
    
}
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *AccountType;
@property(nonatomic,strong)NSString *Createtime;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Money;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *Summary;
@property(nonatomic,strong)NSString *TradingNo;
@property(nonatomic,strong)NSString *Type;//	  "Type ":"1-充值、 2-提现、3-购物、4-退款、5-销售、6-拍卖", //交易类型
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

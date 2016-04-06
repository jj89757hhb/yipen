//
//  AuctionRecord.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  出价记录

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
@interface AuctionRecord : NSObject
@property(nonatomic,strong)NSString *BID;//盆景id
@property(nonatomic,strong)NSString *Createtime;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Offer;
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)YPUserInfo *userInfo;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

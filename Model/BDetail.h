//
//  BDetail.h
//  panjing
//
//  Created by 华斌 胡 on 16/7/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDetail : NSObject{
    
}
@property(nonatomic,strong)NSString *BID;
@property(nonatomic,strong)NSString *CreateTime;
@property(nonatomic,strong)NSString *FromUser;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *NAmount;
@property(nonatomic,strong)NSString *Phase;
@property(nonatomic,strong)NSString *Result;
@property(nonatomic,strong)NSString *ToUser;
@property(nonatomic,strong)NSString *TranNo;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

//
//  CityInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *CityName;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

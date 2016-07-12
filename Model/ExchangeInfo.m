//
//  ExchangeInfo.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/11.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ExchangeInfo.h"

@implementation ExchangeInfo

- (id)initWithKVCDictionary:(NSDictionary *)KVCDic{
    
    if (self = [super init]) {
        //使用kvc进行赋值
        @try {
            [self setValuesForKeysWithDictionary:KVCDic];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    //    NSLog(@"key = %@, value = %@", key, value);
    
}

@end

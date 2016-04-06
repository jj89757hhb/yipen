//
//  AddressInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "Address":"地址"
 "Contacter":"联系人"
 "Mobile":"联系电话"
 "IsDefault":"是否为默认"*/
@interface AddressInfo : NSObject
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *Contacter;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *IsDefault;
@property(nonatomic,strong)NSString *ID;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

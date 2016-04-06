//
//  TreeSort.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeSort : NSObject
@property(nonatomic,strong)NSString *CodeDesc;
@property(nonatomic,strong)NSString *CodeDivision;//种类分类名称
@property(nonatomic,strong)NSString *CodeValue;//种类名称
@property(nonatomic,strong)NSString *ID;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

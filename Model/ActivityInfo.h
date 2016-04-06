//
//  ActivityInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
@interface ActivityInfo : NSObject
@property(nonatomic,strong)NSString *CreateTime;//时间
@property(nonatomic,strong)NSString *Message;//描述
@property(nonatomic,strong)NSString *Title;//标题
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *JoinNum;
@property(nonatomic,strong)NSString *PraisedNum;
@property(nonatomic,strong)NSString *FocusNum;
@property(nonatomic,strong)NSMutableArray *Attach;//图片
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSMutableArray *Praised;
//@property(nonatomic,strong)NSString *UserHeader;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

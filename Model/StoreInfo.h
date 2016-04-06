//
//  StoreInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreInfo : NSObject
@property(nonatomic,strong)NSString *CreateTime;//时间
@property(nonatomic,strong)NSString *Message;//描述
@property(nonatomic,strong)NSString *Title;//标题
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSMutableArray *Attach;//图片
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSString *SID;//店家编码
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *FocusNum;//关注数
@property(nonatomic,strong)NSString *ForwardingNum;//转发数
@property(nonatomic,strong)NSString *CommentsNum;//评论数
@property(nonatomic,strong)NSString *PraisedNum;//被赞数
@property(nonatomic,strong)NSString *CollectionNum;//收藏数
//@property(nonatomic,strong)NSString *UserHeader;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;

@end

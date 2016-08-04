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
@property(nonatomic,strong)NSString *Createtime;//收藏列表又变成了这个？？？
@property(nonatomic,strong)NSString *Message;//描述
@property(nonatomic,strong)NSString *Title;//标题
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *JoinNum;
@property(nonatomic,strong)NSString *PraisedNum;
@property(nonatomic,strong)NSString *FocusNum;
@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *Approver;
@property(nonatomic,strong)NSString *CityID;
@property(nonatomic,strong)NSString *CollectionNum;
@property(nonatomic,strong)NSMutableArray *Comment;//评论
@property(nonatomic,strong)NSMutableArray *Attach;//图片
@property(nonatomic,strong)NSString *CommentsNum;
@property(nonatomic,strong)NSString *STime;//活动开始时间
@property(nonatomic,strong)NSString *ETime;//活动结束时间
@property(nonatomic,strong)NSString *ForwardingNum;
@property(nonatomic,strong)NSString *IsCollect;
@property(nonatomic,strong)NSString *isJoin;
@property(nonatomic,strong)NSString *Cost;//费用
@property(nonatomic,strong)NSString *IsPraise;
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSMutableArray *Praised;
@property(nonatomic,strong)NSString *BrowseNum;//浏览数
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *Contact;//联系人
@property(nonatomic,strong)NSString *Num;//库存
//@property(nonatomic,strong)NSString *UserHeader;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

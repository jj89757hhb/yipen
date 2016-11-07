//
//  YPUserInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPUserInfo : NSObject{
    
}
@property(nonatomic,strong)NSString *Balance;
@property(nonatomic,strong)NSString *CityName;
@property(nonatomic,strong)NSString *CreateTime;
@property(nonatomic,strong)NSString *DeviceID;
@property(nonatomic,strong)NSString *Fans;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *BeID;//用户id(一下是本用户 一下又是对方用户)
@property(nonatomic,strong)NSString *Integral;//积分
@property(nonatomic,strong)NSString *IsCertifi;
@property(nonatomic,strong)NSString *Levels;
@property(nonatomic,strong)NSString *LoginName;
@property(nonatomic,strong)NSString *Memo;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,strong)NSString *OsiteAppid;
@property(nonatomic,strong)NSString *Password;
@property(nonatomic,strong)NSString *PayPassword;
@property(nonatomic,strong)NSString *RoleType;//1 个人会员 2 商家会员
@property(nonatomic,strong)NSString *SID;
@property(nonatomic,strong)NSString *Sex;
@property(nonatomic,strong)NSString *ShareNum;
@property(nonatomic,strong)NSString *Token;
@property(nonatomic,strong)NSString *UserHeader;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,strong)NSString *focusNum;
@property(nonatomic,strong)NSString *praiseNum;
@property(nonatomic,strong)NSString *Descript;//个人介绍
@property(nonatomic,strong)NSString *IsFocus;//用户是否被关注了
@property(nonatomic,strong)NSString *CertifiInfo;
@property(nonatomic,strong)NSString *AliAccount;
@property(nonatomic,strong)NSString *AliName;
@property(nonatomic,strong)NSString *WeChatName;
@property(nonatomic,strong)NSString *UserId;// 赞列表使用
@property(nonatomic,assign)BOOL isSelect;//选择
@property(nonatomic,strong)NSString *UID;//@用户所使用的
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

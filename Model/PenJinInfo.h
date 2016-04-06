//
//  PenJinInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
@interface PenJinInfo : NSObject
@property(nonatomic,strong)NSString *CreateTime;//时间
@property(nonatomic,strong)NSString *Descript;//描述
@property(nonatomic,strong)NSString *Title;//标题
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *JoinNum;
@property(nonatomic,strong)NSString *PraisedNum;
@property(nonatomic,strong)NSMutableArray *Praised;
@property(nonatomic,strong)NSString *FocusNum;
@property(nonatomic,strong)NSMutableArray *Attach;//图片
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSString *Varieties;//品种
@property(nonatomic,strong)NSString *Old;
@property(nonatomic,strong)NSString *Width;//
@property(nonatomic,strong)NSString *Height;
@property(nonatomic,strong)NSString *Diameter;
@property(nonatomic,strong)NSString *InfoType;//发布的类型
@property(nonatomic,strong)NSString *MailFee;//邮费
@property(nonatomic,strong)NSString *MakeUp;//加价
@property(nonatomic,strong)NSString *IsMailed;
@property(nonatomic,strong)NSString *IsMarksPrice;
@property(nonatomic,strong)NSString *Price;//售价
@property(nonatomic,strong)NSString *APrice;//起拍价
@property(nonatomic,strong)NSString *AStartTime;
@property(nonatomic,strong)NSString *AEndTime;
@property(nonatomic,strong)NSString *IsPraise;
@property(nonatomic,strong)NSString *IsCollect;
@property(nonatomic,strong)NSString *IsSale;
@property(nonatomic,strong)NSString *IsAuction;
@property(nonatomic,strong)NSMutableArray *Comment;//评论

//盆缘相关
@property(nonatomic,strong)NSString *ChangeVarieties;
@property(nonatomic,strong)NSString *Location;
@property(nonatomic,strong)NSString *Path;
//@property(nonatomic,strong)NSString *Height;//高度

//@property(nonatomic,strong)NSString *UserHeader;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

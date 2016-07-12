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
@property(nonatomic,strong)NSString *Createtime;//时间
//@property(nonatomic,strong)NSDate *CreateTime;
@property(nonatomic,strong)NSString *Descript;//描述
@property(nonatomic,strong)NSString *Title;//标题
@property(nonatomic,strong)NSString *UID;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *JoinNum;
@property(nonatomic,strong)NSString *PraisedNum;
@property(nonatomic,strong)NSString *CommentsNum;
@property(nonatomic,strong)NSMutableArray *Praised;
@property(nonatomic,strong)NSString *FocusNum;
@property(nonatomic,strong)NSMutableArray *Attach;//图片
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSString *Varieties;//品种
@property(nonatomic,strong)NSString *Other;
@property(nonatomic,strong)NSString *Domestic;
@property(nonatomic,strong)NSString *Origin;
@property(nonatomic,strong)NSString *Size;
@property(nonatomic,strong)NSString *Model;
@property(nonatomic,strong)NSString *Category;

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
@property(nonatomic,strong)NSString *BrowseNum;
//@property(nonatomic,strong)NSString *Height;//高度

//交易助手相关
@property(nonatomic,strong)NSString *isSaleing;
@property(nonatomic,strong)NSString *SendTime;
//@property(nonatomic,strong)NSString *AuctionStatus;
//@property(nonatomic,strong)NSString *BID;//盆景id
//@property(nonatomic,strong)NSString *BuyerID;
//@property(nonatomic,strong)NSString *CreateTime;
//@property(nonatomic,strong)NSString *IsMark;
//@property(nonatomic,strong)NSString *NAmount;//价格
//@property(nonatomic,strong)NSString *Phase;
//@property(nonatomic,strong)NSString *Result;
//@property(nonatomic,strong)NSString *SalerID;
//@property(nonatomic,strong)NSString *TranNo;
//@property(nonatomic,strong)NSString *Type;
//@property(nonatomic,strong)NSString *UserHeader;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

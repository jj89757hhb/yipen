//
//  ShareView.h
//  EEC
//
//  Created by 华斌 胡 on 15/8/12.
//  Copyright (c) 2015年 jiefu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView{
    UIView *bgView;
}
@property(nonatomic,strong)NSString *title;//标题
@property(nonatomic,strong)NSString *content;//内容
@property(nonatomic,strong)NSString *url;//链接
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)NSInteger _id;//活动id 或帖子id
@property(nonatomic,assign)NSInteger enterType;//入口 1、分享活动 2 分享帖子 3分享圈子
@property(nonatomic,strong)NSMutableArray *imageUrls;
+(void)initializePlat;
-(void)shareWithShareType:(EShareType)type isSelectAll:(BOOL)isSelect;
+(void)authSinaWeibo;
+(void)authQQLogin;
+(void)authWeixinLogin;
@end

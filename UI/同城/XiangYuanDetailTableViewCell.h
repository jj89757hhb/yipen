//
//  XiangYuanDetailTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/4/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PraiseView.h"
#import "ImagePlayerView.h"
#import "ActivityInfo.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
static float content_FontSize_XiangYuanDetail=14;
typedef void(^AttentionBlock)(id sender);
@interface XiangYuanDetailTableViewCell : UITableViewCell<ImagePlayerViewDelegate,MWPhotoBrowserDelegate>
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *createTimeL;//创建时间
@property(nonatomic,strong)UILabel *viewL;//浏览
@property(nonatomic,strong)UILabel *praiseL;//看好
@property(nonatomic,strong)UIImageView *treeIV;
@property(nonatomic,strong)UILabel *titleL;//标题
@property(nonatomic,strong)UILabel *contentL;//内容
@property(nonatomic,strong)UILabel *timeL;//活动时间
@property(nonatomic,strong)UILabel *addressL;//地址
@property(nonatomic,strong)UILabel *priceL;//费用
@property(nonatomic,strong)UILabel *joinNumL;//参加
@property(nonatomic,strong)UILabel *contactL;//联系人
@property(nonatomic,strong)UILabel *phoneL;//电话
@property(nonatomic,strong)ActivityInfo *info;
@property(nonatomic,strong)UIButton *attentionBtn;//关注
@property(nonatomic,strong)ImagePlayerView *imagePlayerView;
@property(nonatomic,strong)PraiseView *praiseView;
@property(nonatomic,strong)NSMutableArray *photos;
@property (nonatomic,copy) AttentionBlock attentionBlock;

@end

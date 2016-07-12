//
//  ActivityTableViewCell1.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  没地理位置的

#import <UIKit/UIKit.h>
#import "YPUserInfo.h"
#import "ActivityInfo.h"
typedef void(^ClickHeadBlock)(id sender);
static float activity_Content_Size =14;//内容字体大小
@interface ActivityTableViewCell1 : UITableViewCell{
    
}
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *createTimeL;//创建时间
//@property(nonatomic,strong)UILabel *viewL;//浏览
//@property(nonatomic,strong)UILabel *praiseL;//看好
@property(nonatomic,strong)UIImageView *treeIV;
@property(nonatomic,strong)UILabel *titleL;//标题
@property(nonatomic,strong)UILabel *contentL;//内容
@property(nonatomic,strong)UILabel *timeL;//活动时间
@property(nonatomic,strong)UILabel *addressL;//地址
@property(nonatomic,strong)UILabel *priceL;//费用
@property(nonatomic,strong)UILabel *joinNumL;//参加

@property(nonatomic,strong)ActivityInfo *info;
@property (nonatomic,copy) ClickHeadBlock clickHeadBlock;
@property(nonatomic,strong)UIButton *viewBtn;//浏览
@property(nonatomic,strong)UIButton *praiseBtn;//赞
@property(nonatomic,strong)UIButton *collectBtn;//收藏数
@property(nonatomic,strong)UIButton *commentBtn;//评论数
@end

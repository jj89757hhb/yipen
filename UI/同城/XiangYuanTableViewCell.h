//
//  XiangYuanTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
@interface XiangYuanTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *createTimeL;//创建时间
@property(nonatomic,strong)UILabel *viewL;//浏览
@property(nonatomic,strong)UILabel *praiseL;//看好
@property(nonatomic,strong)UIImageView *treeIV;
@property(nonatomic,strong)UILabel *titleL;//标题
//@property(nonatomic,strong)UILabel *contentL;//内容
@property(nonatomic,strong)UILabel *timeL;//活动时间
@property(nonatomic,strong)UILabel *addressL;//地址
@property(nonatomic,strong)UILabel *priceL;//费用
@property(nonatomic,strong)UILabel *contactL;//联系人
@property(nonatomic,strong)UIImageView *positionIV;

@property(nonatomic,strong)ActivityInfo *info;

@end

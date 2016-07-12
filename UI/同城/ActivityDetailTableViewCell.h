//
//  ActivityDetailTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
#import "PraiseView.h"
static float activity_Content_Size =14;//内容字体大小
@interface ActivityDetailTableViewCell : UITableViewCell{
    
}
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *priceL;
@property(nonatomic,strong)UILabel *timeL;
@property(nonatomic,strong)UILabel *addressL;
@property(nonatomic,strong)UILabel *masterL;
@property(nonatomic,strong)UILabel *contentL;
@property(nonatomic,strong)PraiseView *praiseView;
@property(nonatomic,strong)ActivityInfo *info;
@end

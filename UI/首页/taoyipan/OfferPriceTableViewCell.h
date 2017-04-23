//
//  OfferPriceTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenJinInfo.h"
@interface OfferPriceTableViewCell : UITableViewCell{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *timerL;
@property (weak, nonatomic) IBOutlet UIButton *offerPriceBtn;
@property (weak, nonatomic) IBOutlet UILabel *startPriceL;
@property (weak, nonatomic) IBOutlet UILabel *addPriceL;
@property (weak, nonatomic) IBOutlet UILabel *startL;
@property (weak, nonatomic) IBOutlet UILabel *addL;
@property(nonatomic,strong)CATextLayer *textLayer;
@property(nonatomic,strong)PenJinInfo *info;
@property (weak, nonatomic) IBOutlet UILabel *statusL;

@end

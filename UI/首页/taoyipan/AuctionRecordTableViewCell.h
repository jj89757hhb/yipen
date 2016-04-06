//
//  AuctionRecordTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionRecord.h"
@interface AuctionRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tagL;
@property(nonatomic,strong)AuctionRecord *record;
@property(nonatomic,weak)NSIndexPath *indexPath;
@end

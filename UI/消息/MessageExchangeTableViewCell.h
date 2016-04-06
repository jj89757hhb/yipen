//
//  MessageExchangeTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReplyPriceBlock)(id sender);
@interface MessageExchangeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *replyL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *viewL;
@property (weak, nonatomic) IBOutlet UILabel *praiseL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UIButton *aggreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyPriceBtn;
@property (nonatomic,copy) ReplyPriceBlock replyPriceBlock;
@end

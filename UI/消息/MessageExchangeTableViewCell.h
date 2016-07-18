//
//  MessageExchangeTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeInfo.h"
typedef void(^ReplyPriceBlock)(id sender);
typedef void(^OrderBlock)(id sender);
typedef void(^OfferPriceBlock)(id sender);
typedef void(^BuyBlock)(id sender);
typedef void(^AggreeBlock)(id sender);
typedef void(^RefuseBlock)(id sender);
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
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *price3L;

@property (weak, nonatomic) IBOutlet UILabel *originPriceL;
@property (nonatomic,copy) ReplyPriceBlock replyPriceBlock;
@property (nonatomic,copy) OrderBlock orderBlock;
@property (nonatomic,copy) OfferPriceBlock offerPriceBlock;
@property (nonatomic,copy) BuyBlock buyBlock;
@property(nonatomic,copy)AggreeBlock aggreeBlock;
@property(nonatomic,copy)RefuseBlock refuseBlock;
@property(nonatomic,strong)ExchangeInfo *info;
@property(nonatomic,strong)UIButton *orderBtn;//查询订单
@property(nonatomic,strong)UIButton *buyBtn;//购买
@property(nonatomic,strong)UIButton *negotiatedBtn;//已议价
@property(nonatomic,strong)UIButton *negotiatedFailBtn;//议价失败
@property(nonatomic,strong)UIButton *offerPriceBtn;//报价
@property(nonatomic,strong)NSIndexPath *index;

@end

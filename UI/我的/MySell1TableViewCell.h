//
//  MySell1TableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/1.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SendGoodsBlock)(id sender);
typedef void (^MsgBlock)(id sender);
@interface MySell1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumL;
@property (weak, nonatomic) IBOutlet UILabel *sendStatusL;
@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *sellerL;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *expressNameL;
@property (weak, nonatomic) IBOutlet UILabel *expressNumL;
@property (weak, nonatomic) IBOutlet UILabel *buyTypeL;
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendGoodsBtn;
@property(nonatomic,copy)SendGoodsBlock sendGoodsBlock;
@property(nonatomic,copy)MsgBlock msgBlock;
@end

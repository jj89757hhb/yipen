//
//  WillBuyTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WillBuyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bg1;
@property (weak, nonatomic) IBOutlet UIView *bg2;
@property (weak, nonatomic) IBOutlet UIView *bg3;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *saleNameL;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceL;
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;

@end

//
//  MySellTableViewCell1.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBuyTableViewCell1 : UITableViewCell
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
@property (weak, nonatomic) IBOutlet UIButton *sureGoodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *complaintBtn;

@end

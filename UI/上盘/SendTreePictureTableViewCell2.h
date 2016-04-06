//
//  SendTreePictureTableViewCell2.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Click1Block)(id sender);
typedef void(^Click2Block)(id sender);
typedef void(^Click3Block)(id sender);
typedef void(^Click4Block)(id sender);
@interface SendTreePictureTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *price1L;
@property (weak, nonatomic) IBOutlet UILabel *price2L;
@property (weak, nonatomic) IBOutlet UILabel *rmb1L;
@property (weak, nonatomic) IBOutlet UITextField *treePriceTF;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UILabel *expressPriceL;
@property (weak, nonatomic) IBOutlet UILabel *expressType1L;
@property (weak, nonatomic) IBOutlet UILabel *expressType2L;
@property (weak, nonatomic) IBOutlet UILabel *rmb2L;
@property (weak, nonatomic) IBOutlet UITextField *expressTF;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (nonatomic,copy) Click1Block click1Block;
@property (nonatomic,copy) Click2Block click2Block;
@property (nonatomic,copy) Click3Block click3Block;
@property (nonatomic,copy) Click4Block click4Block;

@end

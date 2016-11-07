//
//  SendTreePictureTableViewCell3.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  拍卖

#import <UIKit/UIKit.h>
typedef void(^Click1Block)(id sender);//卖家包邮
typedef void(^Click2Block)(id sender);//买家自费
typedef void(^ClickStartTimeBlock)(id sender);//开始时间
typedef void(^ClickEndTimeBlock)(id sender);//结束时间

@interface SendTreePictureTableViewCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sellPriceL;//起拍价
@property (weak, nonatomic) IBOutlet UILabel *startTimeL;//开始日期
@property (weak, nonatomic) IBOutlet UILabel *addPriceL;//加价幅度
@property (weak, nonatomic) IBOutlet UILabel *endTimeL;//结束时间
@property (weak, nonatomic) IBOutlet UILabel *expressPriceL;//运费
@property (weak, nonatomic) IBOutlet UILabel *sellExpressL;//卖家包邮
@property (weak, nonatomic) IBOutlet UILabel *buyExpressL;//买家自费
@property (weak, nonatomic) IBOutlet UITextField *expressTF;//运费
@property (weak, nonatomic) IBOutlet UITextField *auctionPriceTF;//起拍价
@property (weak, nonatomic) IBOutlet UITextField *addPriceTF;//加价幅度

@property (nonatomic,copy) Click1Block click1Block;
@property (nonatomic,copy) Click2Block click2Block;
@property (nonatomic,copy) ClickStartTimeBlock startTimeBlock;
@property (nonatomic,copy) ClickEndTimeBlock endTimeBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *v_line_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *x_line_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y_line2_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *x_line2_Height;

@end

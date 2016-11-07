//
//  SentTreePictureTableViewCell1.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SentTreePictureTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topL;

@property (weak, nonatomic) IBOutlet UILabel *heightL;
@property (weak, nonatomic) IBOutlet UILabel *widthL;
@property (weak, nonatomic) IBOutlet UILabel *zhijinL;
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet UITextField *heightTF;
@property (weak, nonatomic) IBOutlet UITextField *zhijinTF;
@property (weak, nonatomic) IBOutlet UITextField *widthTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y1_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y2_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y3_width;

@end

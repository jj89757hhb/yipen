//
//  SendActivityTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *costTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *masterTF;
@property (weak, nonatomic) IBOutlet UILabel *popL;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;

@end

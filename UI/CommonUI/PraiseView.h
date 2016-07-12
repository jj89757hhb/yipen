//
//  PraiseView.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  赞视图

#import <UIKit/UIKit.h>

@interface PraiseView : UIView
-(void)initViewUsers:(NSMutableArray*)users uid:(NSString*)uid praiseNum:(NSString*)praiseNum;
@property(nonatomic,strong)UILabel *praiseL;
@end

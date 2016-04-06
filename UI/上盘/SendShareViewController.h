//
//  SendShareViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/4.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  发布分享 发布出售 发布拍卖

#import "BaseViewController.h"
#import "SlidingViewManager.h"
@interface SendShareViewController : BaseViewController{
    UIButton *memberBtn;
    UIDatePicker *datepicker;
    SlidingViewManager *_svm;
    BOOL isStartTime;
    NSInteger startTime;
    NSInteger endTime;
}
@property(nonatomic,assign)NSInteger enterType;//1、分享2、出售3、拍卖 4、盘缘 5、盘大夫

@end

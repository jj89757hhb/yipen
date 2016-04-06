//
//  SameCityViewController.h
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "DLTabedSlideView.h"
@interface SameCityViewController : BaseViewController{
   DLTabedSlideView *tabedSlideView;
    UITableView *cityTable;
    UIButton *selectbtn;
    UIButton *sendBtn;
}
@end

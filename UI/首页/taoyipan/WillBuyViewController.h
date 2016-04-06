//
//  WillBuyViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "PenJinInfo.h"
@interface WillBuyViewController : BaseViewController{
    UITableView *myTable;
}
@property(nonatomic,strong)PenJinInfo *info;
@end

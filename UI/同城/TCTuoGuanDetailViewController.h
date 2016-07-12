//
//  TuoGuanDetailViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/4/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityInfo.h"
@interface TCTuoGuanDetailViewController : BaseViewController{
       UITableView *myTable;
}
@property(nonatomic,strong)ActivityInfo *info;
@end

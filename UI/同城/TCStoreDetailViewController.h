//
//  StoreDetailViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityInfo.h"
@interface TCStoreDetailViewController : BaseViewController{
    UITableView *myTable;
}
@property(nonatomic,strong)ActivityInfo *info;
@end

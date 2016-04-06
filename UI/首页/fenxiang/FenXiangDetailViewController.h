//
//  FenXiangDetailViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "PenJinInfo.h"
@interface FenXiangDetailViewController : BaseViewController{
    UITableView *myTable;
    NSInteger currentPage;
}
@property(nonatomic,strong)PenJinInfo *info;
@end

//
//  OrderDetailViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "ExchangeInfo.h"
@interface OrderDetailViewController : BaseViewController{
    UITableView *myTable;
    UIView *bottomView;
    UIButton *chatBtn;
}
@property(nonatomic,strong)ExchangeInfo *info;
@property(nonatomic,assign)NSInteger enterType;//0 我买的 1  我卖的
@end

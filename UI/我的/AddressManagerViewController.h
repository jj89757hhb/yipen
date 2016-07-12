//
//  AddressManagerViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressManagerViewController : BaseViewController{
    UITableView *myTable;
    UIView *bottomView;
    UIButton *addBtn;
}
@property(nonatomic,assign)NSInteger enterType;//0 是地址管理入口 1是地址选择
@end

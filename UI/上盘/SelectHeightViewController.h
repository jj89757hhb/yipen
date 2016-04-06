//
//  SelectHeightViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/2.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^SelectBlock)(id sender);
@interface SelectHeightViewController : BaseViewController{
    UITableView *myTable;
}
@property(nonatomic,copy)SelectBlock selectBlock;
@end

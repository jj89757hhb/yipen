//
//  SelectTagViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^SelectBlock)(id sender);
@interface SelectTagViewController : BaseViewController
{
    UITableView *myTable;
}
@property(nonatomic,copy)SelectBlock selectBlock;
@end

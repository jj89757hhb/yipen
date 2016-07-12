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
@property(nonatomic,assign)NSInteger enterType;//选择的入口  1 是 发布盆缘
@end

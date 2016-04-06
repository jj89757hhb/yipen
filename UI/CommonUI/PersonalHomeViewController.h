//
//  PersonalHomeViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityInfo.h"
@interface PersonalHomeViewController : BaseViewController{
    UITableView *myTable;
}
@property(nonatomic,strong)ActivityInfo *info;
@property(nonatomic,strong)YPUserInfo *userInfo;
@end

//
//  TaoYiPanViewController.h
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TaoYiPanViewController : BaseTableViewController{
    NSInteger currentPage;
}
- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView;
-(void)requestDataIsRefresh:(BOOL)isRefresh;
@property(nonatomic,strong)NSMutableDictionary *selectSort;
@end

//
//  ExpertViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/8/2.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
@protocol ExpertDelegate <NSObject>
-(void)selectExpert:(NSMutableArray*)experts;
@end
@interface ExpertViewController : BaseViewController
@property(weak,nonatomic)id<ExpertDelegate> delegate;
@end

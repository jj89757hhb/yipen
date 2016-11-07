//
//  DataSource.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
@interface DataSource : NSObject{
    
}
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSString *State;//省份
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *Street;
@property(nonatomic,assign)float CorrdX;//经度
@property(nonatomic,assign)float CorrdY;//维度
@property(nonatomic,assign)NSInteger lastSection;//搜索中 上次选择的区域
+(DataSource*)sharedDataSource;
+(void)releaseInstance;

@end

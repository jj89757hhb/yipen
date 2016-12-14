//
//  DataSource.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPUserInfo.h"
#import "CityInfo.h"
@interface DataSource : NSObject{
    
}
@property(nonatomic,strong)YPUserInfo *userInfo;
@property(nonatomic,strong)NSString *State;//省份
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *Street;
@property(nonatomic,assign)float CorrdX;//经度
@property(nonatomic,assign)float CorrdY;//维度
@property(nonatomic,assign)NSInteger lastSection;//搜索中 上次选择的区域
@property(nonatomic,assign)NSInteger selectCounter;//选择标签个数
@property(nonatomic,strong)CityInfo *cityInfo;//当前选择的城市
+(DataSource*)sharedDataSource;
+(void)releaseInstance;

@end

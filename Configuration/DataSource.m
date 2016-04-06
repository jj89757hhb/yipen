//
//  DataSource.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

static DataSource *_sharedInstance = nil;
+(DataSource*) sharedDataSource {
    
    @synchronized([DataSource class])
    {
        if (!_sharedInstance){
            _sharedInstance = [[self alloc] init];
        _sharedInstance.userInfo=[[YPUserInfo alloc] init];
        }
        
        return _sharedInstance;
    }
    // to avoid compiler warning
    return nil;
}

-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}

+(id)alloc
{
    @synchronized([DataSource class])
    {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    // to avoid compiler warning
    return nil;
}

+(void)releaseInstance
{
    if(_sharedInstance)
    {
        [_sharedInstance release];
        _sharedInstance=nil;
    }
    
}


@end

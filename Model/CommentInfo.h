//
//  CommentInfo.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentInfo : NSObject{
    
}
@property(nonatomic,strong)NSString *Createtime;
@property(nonatomic,strong)NSString *Message;
@property(nonatomic,strong)NSString *NickName;
@property(nonatomic,strong)NSString *UserId;
- (id)initWithKVCDictionary:(NSDictionary *)KVCDic;
@end

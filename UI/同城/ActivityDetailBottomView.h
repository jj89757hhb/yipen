//
//  ActivityDetailBottomView.h
//  panjing
//
//  Created by 华斌 胡 on 16/7/6.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
typedef void(^CollectBlock)(id sender);
typedef void(^CommentBlock)(id sender);
typedef void(^JoinBlock)(id sender);
@interface ActivityDetailBottomView : UIView{
    
}
@property(nonatomic,strong)UIButton *viewBtn;//预览数
@property(nonatomic,strong)UIButton *collectBtn;//收藏数
@property(nonatomic,strong)UIButton *commentBtn;//评论数
@property(nonatomic,strong)UIButton *joinBtn;//参加
@property(nonatomic,strong)ActivityInfo *info;
@property(nonatomic,copy)CollectBlock collectBlock;
@property(nonatomic,copy)CommentBlock commentBlock;
@property(nonatomic,copy)JoinBlock joinBlock;
//@property(nonatomic,strong)PenJinInfo *
-(void)refreshUI;
@end

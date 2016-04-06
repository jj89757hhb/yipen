//
//  PJCommentTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentInfo.h"
static float comment_FontSize=15;
@interface PJCommentTableViewCell : UITableViewCell{
    
}
@property(nonatomic,strong)UIImageView *commentIV;
@property(nonatomic,strong)UILabel *commentL;
@property(nonatomic,strong)CommentInfo *info;
@end

//
//  ActivityCommentTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentInfo.h"
@interface ActivityCommentTableViewCell : UITableViewCell{
    
}
@property(nonatomic,strong)UIImageView *commentIV;
@property(nonatomic,strong)UILabel *commentL;
@property(nonatomic,strong)CommentInfo *info;
@property(nonatomic,weak)NSIndexPath *indexPath;
@end

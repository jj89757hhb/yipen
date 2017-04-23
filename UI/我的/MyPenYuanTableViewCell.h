//
//  MyPenYuanTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenJinInfo.h"
typedef void(^DeleteAction)(id sender);
@interface MyPenYuanTableViewCell : UITableViewCell{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *memberIV;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *levelIV;
@property (weak, nonatomic) IBOutlet UILabel *sortL;
@property (weak, nonatomic) IBOutlet UILabel *changeL;
@property (weak, nonatomic) IBOutlet UIImageView *treeIV;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tree_HeightL;
@property (weak, nonatomic) IBOutlet UILabel *locationL;
@property (weak, nonatomic) IBOutlet UILabel *changeNumL;
@property(nonatomic,strong)PenJinInfo *info;
@property(nonatomic ,copy)DeleteAction deleteAction;
@property(nonatomic, weak)NSIndexPath *indexPath;
@end

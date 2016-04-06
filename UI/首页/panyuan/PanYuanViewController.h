//
//  PanYuanViewController.h
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface PanYuanViewController : BaseViewController{
    UIView *bgView;
    UIImageView *imageView;
    UIView *bottomView;//底部视图
    UILabel *productNameL;//品种
    UILabel *treeHeightL;//树高
    UILabel *changeL;//想换
    UILabel *positionL;//坐标
    int index;
    UIButton *loveBtn;
    UIButton *noLoveBtn;
    NSInteger dataIndex;
}
- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView;
@end

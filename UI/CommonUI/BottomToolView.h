//
//  BottomToolView.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat BottomToolView_Height=50;
@interface BottomToolView : UIView{
    UIView *topline;
    
}
@property(nonatomic,strong)UIButton *praiseBtn;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *chatBtn;
@property(nonatomic,assign)BOOL isdetail;//是否是详情页
@end

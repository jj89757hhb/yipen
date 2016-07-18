//
//  RemainingPayView.h
//  panjing
//
//  Created by 华斌 胡 on 16/7/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PayBlock)(id sender);//支付
@interface RemainingPayView : UIView{
    UIView *bgView;
    UITextField *pswTF;
}
@property(nonatomic,copy)PayBlock payBlock;
-(void)initViewWithPrice:(NSString*)price;
@end

//
//  BaseViewController.h
//  panjing
//
//  Created by 华斌 胡 on 15/11/16.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NavigationTouchButtonBlock)(id sender);
@interface BaseViewController : UIViewController{
    
}
@property(nonatomic,weak)UIButton *titleBtn;
/*设置navigationcontroller左右按钮*/
- (void)setNavigationBarLeftItem:(NSString *) title itemImg:(UIImage *)itemImg withBlock:(NavigationTouchButtonBlock) block;
- (void)setNavigationBarRightItem:(NSString *) title itemImg:(UIImage *)itemImg withBlock:(NavigationTouchButtonBlock) block;
-(void)hideTabBar:(BOOL)hide animated:(BOOL)isAnimate;//是否隐藏tabbar

@end

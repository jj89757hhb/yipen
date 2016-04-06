//
//  XMTabBarController.h
//  XMTabBar
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
@protocol XMTabBarControllerDelegate <NSObject>

@optional
-(void)xm_selectedViewController:(UIViewController *)viewController;
@end



@interface XMTabBarController : BaseTabBarController


@property (nonatomic, assign) NSInteger selectedItem;

/** 是否显示中间按钮，默认为NO */
@property (nonatomic, assign) BOOL showCenterItem;

/** 中间按钮的图片 */
@property (nonatomic, strong) UIImage * centerItemImage;

/** 中间按钮控制的试图控制器 */
@property (nonatomic, strong) UIViewController * xm_centerViewController;

/** 文字颜色 */
@property (nonatomic, strong) UIColor * textColor;

@property (nonatomic, weak) id<XMTabBarControllerDelegate>XMDelegate;


/**
 *  指定item设置badgeValue
 */
-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index;

/**
 *  隐藏或显示TabBar
 */
-(void)xmTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

/**
 *  隐藏或显示中间试图控制器
 */
-(void)showCenterViewController:(BOOL)show animated:(BOOL)animated;

- (id)initWithTabBarSelectedImages:(NSMutableArray *)selected
                      normalImages:(NSMutableArray *)normal
                            titles:(NSMutableArray *)titles;





@end




@interface XMButton : UIButton

@property (nonatomic, assign) NSUInteger badgeValue;
+ (instancetype)xm_shareButton;

@end








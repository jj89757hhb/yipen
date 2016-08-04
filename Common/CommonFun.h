//
//  CommonFun.h
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFun : NSObject{
    
}
+(BOOL)isSpaceCharacter:(NSString*)text;
+(NSString*)translateDateWithCreateTime:(NSInteger)createTime;
+(NSString*)countdown:(long long)lastTime;
+(NSMutableAttributedString*)timerFireMethod:(long long)time;
+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)contentSize;
+ (UIViewController *)viewControllerHasNavigation:(UIView *)view;
+ (NSString *)delDecimal:(NSString *)inputNum;
+ (UIViewController *)viewControllerHasNavgation:(UIView *)aView;
@end

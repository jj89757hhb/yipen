//
//  CustomImageView.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapBlock)(id sender);//出价
@interface CustomImageView : UIImageView{
    
}
@property(nonatomic,assign)NSInteger index;
@property (nonatomic,copy) TapBlock tapBlock;
-(void)addTapAction;
@end

//
//  EditNameViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^ChangeNameBlock)(id sender);
@interface EditNameViewController : BaseViewController{
    
}
@property (nonatomic,copy) ChangeNameBlock changeNameBlock;
@end

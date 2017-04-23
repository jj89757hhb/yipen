//
//  MyWebViewViewController.h
//  EduSoho
//
//  Created by 华斌 胡 on 16/1/12.
//  Copyright © 2016年 Kuozhi Network Technology. All rights reserved.
//

#import "BaseViewController.h"

@interface MyWebViewViewController : BaseViewController{
    UIWebView *myWebView;
}
@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,strong)NSString *_title;
@property(nonatomic,strong)NSString *methodName;//服务端接口名称
@property(nonatomic,assign)NSInteger enterType;// 0用户说明  1 用户协议
@end

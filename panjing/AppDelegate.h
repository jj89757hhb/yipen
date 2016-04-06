//
//  AppDelegate.h
//  panjing
//
//  Created by 华斌 胡 on 15/11/16.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate>{
    BMKLocationService *_locService;
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end


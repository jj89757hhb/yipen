//
//  AppDelegate.m
//  panjing
//
//  Created by 华斌 胡 on 15/11/16.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "AppDelegate.h"
#import "XMTabBarController.h"
#import "HomeViewController.h"
#import "SameCityViewController.h"
#import "MsgListViewController.h"
#import "MyViewController.h"
#import "BaseNavController.h"
#import "ChatListViewController.h"
#import "MessageCenterViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <ShareSDK/ShareSDK.h>
#import "ShareView.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import "GeTuiSdk.h"
//#import <SMS_SDK/SMSSDK.h>
//#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30" // online key

#define UMENG_APPKEY @"563755cbe0f55a5cb300139c"
//个推
#define kGtAppId @"f2DEQJXOhj5o0neVePDsT3"
#define kGtAppKey @"VFJYptUtOoA9qLdVvROQJ7"
#define kGtAppSecret @"gnGihBDG2L9T00B9IRYT74"

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

@interface AppDelegate ()<RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource,BMKGeneralDelegate,GeTuiSdkDelegate>
@property(nonatomic,strong)XMTabBarController *tabBar;
@property(nonatomic,strong)NSString *clientId;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NotificationCenter addObserver:self selector:@selector(upLoadGeTuiClientid) name:@"upLoadGeTuiClientid" object:nil];
    [self registerNotification];
//    [ShareSDK registerApp:AppKey_ShareSDK];
    //2. 初始化社交平台
    //2.1 代码初始化社交平台的方法
    [ShareView initializePlat];
//    [SMSSDK registerApp:AppKey_sms withSecret:AppSecret_sms];
//     [WXApi registerApp:@"wxc854949473b2b966" withDescription:@"demo 2.0"];
       [WXApi registerApp:@"wxc854949473b2b966"];
    [NotificationCenter addObserver:self selector:@selector(loginOut) name:KloginOutNotify object:nil];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"首页-未选"],[UIImage imageNamed:@"同城-未选"],[UIImage imageNamed:@"消息-未选"],[UIImage imageNamed:@"我的-未选"], nil];
    NSMutableArray * selectedArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"首页-选中"],[UIImage imageNamed:@"同城-选中"],[UIImage imageNamed:@"消息-选中"],[UIImage imageNamed:@"我的-选中"], nil];
    NSMutableArray * titles = [[NSMutableArray alloc]initWithObjects:@"首页",@"同城",@"消息",@"我的", nil];
    
    
    HomeViewController * homeCtr = [[HomeViewController alloc]init];
    SameCityViewController * sameCtr = [[SameCityViewController alloc]init];
//    MsgListViewController * msgCtr = [[MsgListViewController alloc]init];
//    ChatListViewController *chatCtr=[[ChatListViewController alloc] init];
    MessageCenterViewController *chatCtr=[[MessageCenterViewController alloc] init];
    
    MyViewController * myCtr = [[MyViewController alloc]init];
    
    BaseNavController * nav1 = [[BaseNavController alloc]initWithRootViewController:homeCtr];
//        [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_line"] forBarMetrics:UIBarMetricsDefault];
//    nav1.navigationBar.shadowImage = [UIImage imageNamed:@"nav_line"];
//        [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bg"] forBarMetrics:UIBarMetricsDefault];
    
    BaseNavController * nav2 = [[BaseNavController alloc]initWithRootViewController:sameCtr];
    BaseNavController * nav3 = [[BaseNavController alloc]initWithRootViewController:chatCtr];
    BaseNavController * nav4 = [[BaseNavController alloc]initWithRootViewController:myCtr];
    
    
    self.tabBar = [[XMTabBarController alloc]initWithTabBarSelectedImages:selectedArray normalImages:array titles:titles];
    self.tabBar.showCenterItem = YES;
//    self.tabBar.centerItemImage = [UIImage imageNamed:@"btn_release.png"];
       self.tabBar.centerItemImage = [UIImage imageNamed:@"发布"];

    self.tabBar.viewControllers = @[nav1,nav2,nav3,nav4];
    self.tabBar.textColor = [UIColor darkGrayColor];
//    [self.tabBar tabBarBadgeValue:345 item:2];
//    [self.tabBar tabBarBadgeValue:3 item:1];
    
//    self.tabBar.xm_centerViewController = [[XMTestViewController alloc] init];
//    self.window.rootViewController = self.tabBar;
 
    NSLog(@"UserId]:%@",[DEFAULTS objectForKey:UserId]);
    if ([[DEFAULTS objectForKey:UserId] length]) {//已登录
        [DataSource sharedDataSource].userInfo.ID=[DEFAULTS objectForKey:UserId];
        [DataSource sharedDataSource].userInfo.NickName=[DEFAULTS objectForKey:UserNickName];
        [DataSource sharedDataSource].userInfo.UserHeader=[DEFAULTS objectForKey:UserPortraitUri];
        if ([DEFAULTS objectForKey:Mobile]) {
                  [DataSource sharedDataSource].userInfo.Mobile=[DEFAULTS objectForKey:Mobile];
        }
  

        [self goHomeView];
        [self.window makeKeyAndVisible];
    }
    else{
        UIViewController *navCtr=[Storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];//LoginView LoginNav
        self.window.rootViewController = navCtr;
        [self.window makeKeyAndVisible];
    }
    
    
    BOOL debugMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"rongcloud appkey debug"];
    //debugMode是为了切换appkey测试用的，请应用忽略关于debugMode的信息，这里直接调用init。
    if (!debugMode) {
        
        //初始化融云SDK
        [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    }
    
    // 注册自定义测试消息
//    [[RCIM sharedRCIM] registerMessageType:[RCDTestMessage class]];
    
    //设置会话列表头像和会话界面头像
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    if (iPhone6Plus) {
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(56, 56);
    } else {
        NSLog(@"iPhone6 %d", iPhone6);
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    }
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //设置用户信息源和群组信息源
     [[RCIM sharedRCIM] setUserInfoDataSource:self];
     [[RCIM sharedRCIM] setGroupInfoDataSource:self];
//    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
//    [RCIM sharedRCIM].groupInfoDataSource = RCDDataSource;
//    //设置群组内用户信息源。如果不使用群名片功能，可以不设置
//    [RCIM sharedRCIM].groupUserInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    [RCIM sharedRCIM].disableMessageAlertSound=NO;
    [RCIM sharedRCIM].disableMessageNotificaiton=NO;
    [RCIM sharedRCIM].enablePersistentUserInfoCache=YES;
    
    //登录
//    NSString *token =[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
//    NSString *token=@"TI9F2LuaYEiqzMus85S51LwDOnHV8LIqjMA7EZsSql3xp+cBNwNMaWRjax2xqd5pfk0nxxrQARjlP1+MqJyXyA==";//36  18857871640
//    NSString *token=@"lRwBzD35sOlg6JFHfDV3LrGZqxK28HwRmXUCyKz4CKRx3+tfvm03lbllaAaaAUeqk5L2Zi+gkTkGXXbXU4kgAw==";//38
    NSString *userId=[DEFAULTS objectForKey:@"userId"];
    NSString *userName = [DEFAULTS objectForKey:@"userName"];
    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
    NSString *userNickName = [DEFAULTS objectForKey:@"userNickName"];
    NSString *userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
    
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:userId,@"userId", userNickName,@"name",userPortraitUri,@"portraitUri",nil];
//    [HttpConnection  getToken:dic WithBlock:^(id response, NSError *error) {
//        
//    }];
    
//    if (token.length && userId.length && password.length && !debugMode) {

    
    
    
    //首先获取个人资料 拿到融云token
    if ([DataSource sharedDataSource].userInfo.ID) {
        NSString *param2=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
        [HttpConnection getOwnerInfoWithParameter:param2 WithBlock:^(id response, NSError *error) {
            if (!error) {
                NSString *token=[DataSource sharedDataSource].userInfo.Token;
                if (token.length && userId.length) {
                    RCUserInfo *_currentUserInfo =
                    [[RCUserInfo alloc] initWithUserId:userId
                                                  name:userNickName
                                              portrait:userPortraitUri];
                    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
                    [[RCIM sharedRCIM] refreshUserInfoCache:_currentUserInfo withUserId:userId];
                    [[RCIM sharedRCIM] connectWithToken:token
                                                success:^(NSString *userId) {
                                                    NSLog(@"链接融云成功:%@",userId);
                                                }
                                                  error:^(RCConnectErrorCode status) {
                                                      
                                                  }
                                         tokenIncorrect:^{
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 
                                             });
                                         }];
                };
            }
            else{
                NSLog(@"获取个人资料失败");
            }
            
        }];
        
    }
 
   
    /**
     * 统计推送打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    /**
     * 获取融云推送服务扩展字段1
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromLaunchOptions:launchOptions];
    if (pushServiceData) {
        NSLog(@"该启动事件包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"%@", pushServiceData[key]);
        }
    } else {
        NSLog(@"该启动事件不包含来自融云的推送服务");
    }
    
    //统一导航条样式
//    UIFont *font = [UIFont systemFontOfSize:19.f];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : font,
//                                     NSForegroundColorAttributeName : [UIColor whiteColor]
//                                     };
//    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance]
//     setBarTintColor:[UIColor colorWithHexString:@"0195ff" alpha:1.0f]];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
     //进入主页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHomeView) name:@"goHomeView" object:nil];
    //退出到登录页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goLoginView) name:@"goLoginView" object:nil];
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:AppKey_BaiduMap generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.distanceFilter=200;
    //启动LocationService
    [_locService startUserLocationService];
       [UINavigationBar appearance].translucent=NO;
    [NotificationCenter addObserver:self selector:@selector(queryPersonalInfo) name:@"QueryPersonalInfo" object:nil];
    NSString *(^thisBlock) (NSString *thisName) = ^(NSString *name){
        return [NSString stringWithFormat:@"%@:%@",@"name",name];
    };
    NSLog(@"%@",thisBlock(@"xiaoming"));
    [self runGeTuiSDK];
    return YES;
}

//查询个人资料、连接融云服务器
-(void)queryPersonalInfo{
    NSString *userId=[DEFAULTS objectForKey:@"userId"];
    NSString *userName = [DEFAULTS objectForKey:@"userName"];
    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
    NSString *userNickName = [DEFAULTS objectForKey:@"userNickName"];
    NSString *userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
    
    //首先获取个人资料 拿到融云token
    if ([DataSource sharedDataSource].userInfo.ID) {
        NSString *param2=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
        [HttpConnection getOwnerInfoWithParameter:param2 WithBlock:^(id response, NSError *error) {
            if (!error) {
                NSString *token=[DataSource sharedDataSource].userInfo.Token;
                if (token.length && userId.length) {
                    RCUserInfo *_currentUserInfo =
                    [[RCUserInfo alloc] initWithUserId:userId
                                                  name:userNickName
                                              portrait:userPortraitUri];
                    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
                    [[RCIM sharedRCIM] refreshUserInfoCache:_currentUserInfo withUserId:userId];
                    [[RCIM sharedRCIM] connectWithToken:token
                                                success:^(NSString *userId) {
                                                    NSLog(@"链接融云成功:%@",userId);
                                                }
                                                  error:^(RCConnectErrorCode status) {
                                                      
                                                  }
                                         tokenIncorrect:^{
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 
                                             });
                                         }];
                };
            }
            else{
                NSLog(@"获取个人资料失败");
            }
            
        }];
        
    }

}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [DataSource sharedDataSource].CorrdX=userLocation.location.coordinate.longitude;
    [DataSource sharedDataSource].CorrdY=userLocation.location.coordinate.latitude;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *dic = [placemark addressDictionary];
            // Country(国家) State(城市) SubLocality(区) Name全称
            NSLog(@"%@", [dic objectForKey:@"Name"]);
            [DataSource sharedDataSource].City=[dic objectForKey:@"City"];
        }
    }];
}


-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
//    if ([[DEFAULTS objectForKey:UserId] isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId=userId;
//        user.userId = [DEFAULTS objectForKey:UserId];
//        user.name = [DEFAULTS objectForKey:UserNickName];
//        user.portraitUri =[DEFAULTS objectForKey:UserPortraitUri];
        return completion(user);
//    }
    return completion(nil);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)loginOut{
    UIViewController *navCtr=[Storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];//LoginView LoginNav
    self.window.rootViewController = navCtr;
    [DEFAULTS removeObjectForKey:UserNickName];
    [DEFAULTS removeObjectForKey:UserPortraitUri];
    [DEFAULTS removeObjectForKey:UserPwd];
    [DEFAULTS removeObjectForKey:UserId];
    [DEFAULTS synchronize];
    
}
/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
}

- (void)redirectNSlogToDocumentFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmmss"];
    NSString *formattedDate = [dateformatter stringFromDate:currentDate];
    
    NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];
    NSString *logFilePath =
    [documentDirectory stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stderr);
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}


#pragma mark - RCWKAppInfoProvider
- (NSString *)getAppName {
    return @"融云";
}

- (NSString *)getAppGroups {
    return @"group.com.RCloud.UIComponent.WKShare";
}

//- (NSArray *)getAllUserInfo {
//    return [RCDDataSource getAllUserInfo:^ {
//        [[RCWKNotifier sharedWKNotifier] notifyWatchKitUserInfoChanged];
//    }];
//}
//- (NSArray *)getAllGroupInfo {
//    return [RCDDataSource getAllGroupInfo:^{
//        [[RCWKNotifier sharedWKNotifier] notifyWatchKitGroupChanged];
//    }];
//}
//- (NSArray *)getAllFriends {
//    return [RCDDataSource getAllFriends:^ {
//        [[RCWKNotifier sharedWKNotifier] notifyWatchKitFriendChanged];
//    }];
//}
- (void)openParentApp {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"rongcloud://connect"]];
}
- (BOOL)getNewMessageNotificationSound {
    return ![RCIM sharedRCIM].disableMessageAlertSound;
}
- (void)setNewMessageNotificationSound:(BOOL)on {
    [RCIM sharedRCIM].disableMessageAlertSound = !on;
}
- (void)logout {
    [DEFAULTS removeObjectForKey:@"userName"];
    [DEFAULTS removeObjectForKey:@"userPwd"];
    [DEFAULTS removeObjectForKey:@"userToken"];
    [DEFAULTS removeObjectForKey:@"userCookie"];
    [DEFAULTS removeObjectForKey:UserId];
    [DEFAULTS removeObjectForKey:UserNickName];
    [DEFAULTS removeObjectForKey:UserPortraitUri];
    [DEFAULTS removeObjectForKey:UserPwd];
    [DEFAULTS synchronize];
    if (self.window.rootViewController != nil) {
//        UIStoryboard *storyboard =
//        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        RCDLoginViewController *loginVC =
//        [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
//        UINavigationController *navi =
//        [[UINavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = navi;
    }
    [[RCIMClient sharedRCIMClient] disconnect:NO];
}
- (BOOL)getLoginStatus {
    NSString *token = [DEFAULTS stringForKey:@"userToken"];
    if (token.length) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - RCIMConnectionStatusDelegate

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
//        RCDLoginViewController *loginVC = [[RCDLoginViewController alloc] init];
//        UINavigationController *_navi =
//        [[UINavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = _navi;
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            RCDLoginViewController *loginVC =
//            [[RCDLoginViewController alloc] init];
//            UINavigationController *_navi = [[UINavigationController alloc]
//                                             initWithRootViewController:loginVC];
//            self.window.rootViewController = _navi;
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:nil
                                       message:@"Token已过期，请重新登录"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
}

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    if ([message.content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *msg=(RCInformationNotificationMessage *)message.content;
        //NSString *str = [NSString stringWithFormat:@"%@",msg.message];
        if ([msg.message rangeOfString:@"你已添加了"].location!=NSNotFound) {
//            [RCDDataSource syncFriendList:^(NSMutableArray *friends) {
//            }];
        }
    }
}

-(void)goHomeView{
    self.window.rootViewController = self.tabBar;
    [self upLoadGeTuiClientid];
}

-(void)goLoginView{
    UIViewController *navCtr=[Storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];//LoginView LoginNav
    self.window.rootViewController = navCtr;
}

//-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
//{
//    
//}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
          return YES;
    }
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    NSLog(@"url.host:%@",url.host);
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {//这里block不调用
            NSLog(@"result appdelegate = %@",resultDic);
            // 9000 订单支付成功 8000 正在处理中 4000 订单支付失败 6001 用户中途取消 6002 网络连接出错
            NSLog(@"11111:%@",resultDic[@"resultStatus"]);
            if ([resultDic[@"resultStatus"] integerValue]==9000) {//支付成功
                
//                [NotificationCenter postNotificationName:ZFB_Pay_Success_Noti object:nil];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryPersonalInfo2" object:nil];
            }
        }];
        return YES;
    }
    if ([url.host isEqualToString:@"pay"]) {
        NSArray *array=[url.absoluteString componentsSeparatedByString:@"ret="];
        if (array.count==2) {
            if ([array[1] integerValue]==0) {//成功
                      [NotificationCenter postNotificationName:WeiXin_Pay_Success_Noti object:nil];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryPersonalInfo2" object:nil];
            }
        }
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}


//启动个推sdk
-(void)runGeTuiSDK{
    // [ GTSdk ]：是否允许APP后台运行
    //    [GeTuiSdk runBackgroundEnable:YES];
    
    // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
    // [ GTSdk ]：自定义渠道
    [GeTuiSdk setChannelId:@"yipen-ios"];
    
    // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNs - custom method - 开发者自定义的方法
    //    [self registerRemoteNotification];
}


#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - (App运行在后台)  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    // 显示APNs信息到页面
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], userInfo];
    NSLog(@"didReceiveRemoteNotification:%@",record);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // [ GTSdk ]：Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - iOS 10中收到推送消息

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}
#endif


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [ GTSdk ]：个推SDK已注册，返回clientId
    NSLog(@">>[GTSdk RegisterClient]:%@", clientId);
    self.clientId = clientId;
    [self upLoadGeTuiClientid];
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    //    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    // 页面显示日志
    //    NSString *record = [NSString stringWithFormat:@"%d, %@, %@%@", ++_lastPayloadIndex, [self formateTime:[NSDate date]], payloadMsg, offLine ? @"<离线消息>" : @""];
    //    XTLog(@"record:%@",record);
    
    // 控制台打印日志
    NSString *msg = [NSString stringWithFormat:@"%@ : %@%@", [self formateTime:[NSDate date]], payloadMsg, offLine ? @"<离线消息>" : @""];
    NSLog(@">>[GTSdk ReceivePayload]:%@, taskId: %@, msgId :%@", msg, taskId, msgId);
//    if (offLine&&_isClickNotify) {//离线的消息才跳转
//        _isClickNotify = NO;
//        UIViewController *topVC = [self topViewController];
//        MessageCenterViewController *ctr = [[MessageCenterViewController alloc] init];
//        [topVC.navigationController pushViewController:ctr animated:YES];
//        
//        
//    }
//    else{
//        
//    }
    
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 页面显示：上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"GeTuiSdkDidSendMessage:%@",record);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // 页面显示：个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"GeTuiSdkDidOccurError:%@",[error localizedDescription]);
    
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 页面显示更新通知SDK运行状态
    //    [_viewController updateStatusView:self];
}

/** SDK设置推送模式回调  */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    // 页面显示错误信息
    if (error) {
        NSLog(@"GeTuiSdkDidSetPushMode:%@",[error localizedDescription]);
        return;
    }
    
    
}
- (NSString *)formateTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

//注册通知
-(void)registerNotification{
    
    /**
     * 推送处理1
     */
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                NSLog(@"通知授权");
            }
            else{
                
            }
            
            
        }];
    }
    else{
        if ([[UIApplication sharedApplication]
             respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            //注册推送, 用于iOS8以及iOS8之后的系统
            UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                    settingsForTypes:(UIUserNotificationTypeBadge |
                                                                      UIUserNotificationTypeSound |
                                                                      UIUserNotificationTypeAlert )
                                                    categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            //        [application registerForRemoteNotifications];
        } else {
            //注册推送，用于iOS8之前的系统
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
            UIRemoteNotificationTypeAlert |
            UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        }
    }
}

//上传到个推
-(void)upLoadGeTuiClientid{
    if (_clientId.length==0
        ||[DataSource sharedDataSource].userInfo.ID.length==0) {
        return;
    }
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc] init];
    [parmas setObject:[DataSource sharedDataSource].userInfo.ID forKey:@
     "Uid"];
    [parmas setObject:_clientId forKey:@
     "Token"];
    [HttpConnection upLoadGeTuiClientId:parmas WithBlock:^(id response, NSError *error) {
//        NSLog(@"上传个推:%@",res)
        
    }];
}

@end

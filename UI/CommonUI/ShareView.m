//
//  ShareView.m
//  EEC
//
//  Created by 华斌 胡 on 15/8/12.
//  Copyright (c) 2015年 jiefu. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//#import <QZoneConnection/ISSQZoneApp.h>
@implementation ShareView
//static float bgView_Height=220;
static float bgView_Height=160;
static float share_Btn_Width=50;
static NSString *event_Share_Url=@"/share/event/";//分享活动路径组成部分
static NSString *topic_Share_Url=@"/share/thread/";//分享帖子
static NSString *circle_Share_Url=@"/share/group/";//分享圈子
//static NSString *shareUrl=@"http://u.ec54.com:8000/";
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        NSArray *arrayName1=[[NSArray alloc] initWithObjects:@"新浪微博",@"腾讯微博",@"QQ空间", nil];
//        NSArray *arrayName2=[[NSArray alloc] initWithObjects:@"微信好友",@"微信朋友圈",@"QQ", nil];
        NSArray *titles =[[NSArray alloc] initWithObjects:@"微信好友",@"微信朋友圈",@"QQ好友",@"新浪微博",nil];
        //微信好友 朋友圈 qq  微博
        NSArray *imagesName=[[NSArray alloc] initWithObjects:@"微信好友",@"朋友圈",@"qq",@"微博", nil];
        NSArray *arrayName2=[[NSArray alloc] initWithObjects:@"微信朋友圈",@"QQ", nil];
        float offx=20;
        float offY=20;
        float off_Center=(SCREEN_WIDTH-offx*2-share_Btn_Width*4)/3;//中间的间隙
        bgView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bgView_Height)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        //动画效果
        [UIView animateWithDuration:0.3
                         animations:^{
                             [bgView setFrame:CGRectMake(0, SCREEN_HEIGHT-bgView_Height, SCREEN_WIDTH, bgView_Height)];
                         } completion:^(BOOL finished) {
                             
                         }];
        for (int j=0; j<1; j++) {
            for (int i=0;i<4;i++) {
//                if (j==1&&i==2) {
//                    break;
//                }
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(offx+off_Center*i+share_Btn_Width*i, offY+share_Btn_Width*j+25*j, share_Btn_Width, share_Btn_Width)];
                UILabel *titleL=[[UILabel alloc] initWithFrame:CGRectMake(btn.frame.origin.x-10, CGRectGetMaxY(btn.frame), btn.frame.size.width+20, 20)];
                [titleL setBackgroundColor:Clear_Color];
                [titleL setTextAlignment:NSTextAlignmentCenter];
                [titleL setFont:[UIFont systemFontOfSize:12]];
                if (j==0) {
                    btn.tag=10+i;
                }
                else{
                    btn.tag=13+i;
                }
               
                if (j==0) {
                    [btn setImage:[UIImage imageNamed:imagesName[i]] forState:UIControlStateNormal];
//                    [btn setTitle:arrayName1[i] forState:UIControlStateNormal];
                    titleL.text=titles[i];
                }
                else{
                    [btn setImage:[UIImage imageNamed:arrayName2[i]] forState:UIControlStateNormal];
//                    [btn setTitle:arrayName2[i] forState:UIControlStateNormal];
                    titleL.text=arrayName2[i];
                }
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font=[UIFont systemFontOfSize:10];
//                [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
//                [btn setTitleEdgeInsets: ]
//                [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
//                [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
                [bgView addSubview:btn];
                [bgView addSubview:titleL];
                [btn addTarget:self action:@selector(clientShareClickHandler:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
          float Btnoffx=10;
        UIButton *cancel=[[UIButton alloc] initWithFrame:CGRectMake(Btnoffx, share_Btn_Width+30*2+10, SCREEN_WIDTH-Btnoffx*2, 30)];
        [cancel setTitle:@"取 消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancel.layer.cornerRadius=5;
        cancel.clipsToBounds=YES;
        cancel.layer.borderWidth=0.5;
        cancel.layer.borderColor=MIDDLEBLACK.CGColor;
        [bgView addSubview:cancel];
        [cancel setUserInteractionEnabled:NO];
       
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //动画效果
    [UIView animateWithDuration:0.3
                     animations:^{
                         [bgView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bgView_Height)];
                     } completion:^(BOOL finished) {
                           [self removeFromSuperview];
                     }];
  
}

- (void)clientShareClickHandler:(UIButton*)sender
{
    if (self.content.length>50) {
           self.content=[self.content substringToIndex:50];
    }
//
    NSString *shareURL=nil;
//    if (self.enterType==1) {//活动
//        shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,event_Share_Url,self._id];
//    }
//    else if (self.enterType==2){//帖子
//       shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,topic_Share_Url,self._id];
//    }
//    else if(self.enterType==3){//圈子
//        shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,circle_Share_Url,self._id];
//    }
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:IMAGE_NAME ofType:IMAGE_EXT];
//    NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
//    if (sender.tag==10) {//新浪微博
////         NSString *content=[NSString stringWithFormat:@"%@ %@",_content,shareURL];//拼接url
//        NSString *content=_content;
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:content
//                                           defaultContent:@""
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:_title
//                                                      url:shareURL
//                                              description:content
//                                                mediaType:SSPublishContentMediaTypeNews];
//        //新浪微博如果选择SSPublishContentMediaTypeNews 只能传 content 出去 title url不能传
//        
//        [ShareSDK clientShareContent:publishContent
//                                type:ShareTypeSinaWeibo
//                       statusBarTips:YES
//                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                  
//                                  if (state == SSPublishContentStateSuccess)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                      [SVProgressHUD showSuccessWithStatus:@"分享成功"];
//                                  }
//                                  else if (state == SSPublishContentStateFail)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  }
//                              }];
//    }
////    else if(sender.tag==11){
////        
////    }
//    else if(sender.tag==11){//qq空间
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:_content
//                                           defaultContent:@""
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:_title
//                                                      url:shareURL
//                                              description:_content
//                                                mediaType:SSPublishContentMediaTypeNews];
//        
//        [ShareSDK clientShareContent:publishContent
//                                type:ShareTypeQQSpace
//                       statusBarTips:YES
//                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                  
//                                  if (state == SSPublishContentStateSuccess)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                      [SVProgressHUD showSuccessWithStatus:@"分享成功"];
//                                  }
//                                  else if (state == SSPublishContentStateFail)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  }
//                              }];
//    }
//    else if(sender.tag==12){//微信好友
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:_content
//                                           defaultContent:@""
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:_title
//                                                      url:shareURL
//                                              description:_content
//                                                mediaType:SSPublishContentMediaTypeNews];
//        
//        [ShareSDK clientShareContent:publishContent
//                                type:ShareTypeWeixiSession
//                       statusBarTips:YES
//                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                  
//                                  if (state == SSPublishContentStateSuccess)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                      [SVProgressHUD showSuccessWithStatus:@"分享成功"];
//                                  }
//                                  else if (state == SSPublishContentStateFail)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  }
//                              }];
//
//    }
//    else if(sender.tag==13){//微信朋友圈
//        //构造分享内容
//        id<ISSContent> publishContent = [ShareSDK content:_content
//                                           defaultContent:@""
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:_title
//                                                      url:shareURL
//                                              description:_content
//                                                mediaType:SSPublishContentMediaTypeNews];
//        
//        [ShareSDK clientShareContent:publishContent
//                                type:ShareTypeWeixiTimeline
//                       statusBarTips:YES
//                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                  
//                                  if (state == SSPublishContentStateSuccess)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                      [SVProgressHUD showSuccessWithStatus:@"分享成功"];;
//                                  }
//                                  else if (state == SSPublishContentStateFail)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  }
//                              }];
//
//    }
//    else if (sender.tag==14){//qq
//        id<ISSContent> publishContent = [ShareSDK content:_content
//                                           defaultContent:@""
//                                                    image:[ShareSDK imageWithPath:imagePath]
//                                                    title:_title
//                                                      url:shareURL
//                                              description:_content
//                                                mediaType:SSPublishContentMediaTypeNews];
//        
//        [ShareSDK clientShareContent:publishContent
//                                type:ShareTypeQQ
//                       statusBarTips:YES
//                              result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                  
//                                  if (state == SSPublishContentStateSuccess)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];;
//                                  }
//                                  else if (state == SSPublishContentStateFail)
//                                  {
////                                      NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  }
//                              }];
//    }
    
    SSDKPlatformType platformType=SSDKPlatformSubTypeWechatSession;
        SSDKContentType contentType=SSDKContentTypeAuto;
    if (sender.tag==10) {//微信
        platformType=SSDKPlatformSubTypeWechatSession;
    }
    else if(sender.tag==11){//朋友圈
        platformType=SSDKPlatformSubTypeWechatTimeline;
    }
    else if(sender.tag==12){//qq好友
        platformType=SSDKPlatformSubTypeQQFriend;
    }
    else if(sender.tag==13){//微博
        platformType=SSDKPlatformTypeSinaWeibo;
        contentType=SSDKContentTypeImage;
    }
    
    NSArray* imageArray = @[[UIImage imageNamed:@"logo_home.png"]];

//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
//    NSString *imageurl=_imageUrls[0];
//    NSURL *url=[NSURL URLWithString:imageurl];
    //_imageUrls.count?_imageUrls:imageArray
    //创建分享参数  【发现新浪微博如果 images 是非image对象 分享失败！！！！】
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享盆景"
                                     images:_imageUrls.count?_imageUrls:imageArray//传入要分享的图片
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享盆景"
                                       type:contentType];
    
    //进行分享
    [ShareSDK share:platformType //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
         if (state==SSDKResponseStateSuccess) {
              [SVProgressHUD showInfoWithStatus:@"分享成功"];
         }
         else if(state==SSDKResponseStateCancel){
             NSLog(@"用户取消");
         }
         else if(state==SSDKResponseStateFail){
             [SVProgressHUD showInfoWithStatus:@"分享失败"];
         }
     }];
   
     [self removeFromSuperview];
}


/**
 *  分享
 *
 *  @param type     平台类型
 *  @param isSelect 是否选择了两个平台
 */
-(void)shareWithShareType:(EShareType)type isSelectAll:(BOOL)isSelect{
//    static NSInteger count=0;
//    ShareType shareType;
//    if (type==KSina) {
//        shareType=ShareTypeSinaWeibo;
//    }
//    else if (type==KWeiXin){
//        shareType=ShareTypeWeixiSession;
//    }
//    NSString *shareURL=nil;
//    if (self.enterType==1) {//活动
//        shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,event_Share_Url,self._id];
//    }
//    else if (self.enterType==2){//帖子
//        shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,topic_Share_Url,self._id];
//
//    }
//    else if(self.enterType==3){//圈子
//        shareURL=[NSString stringWithFormat:@"%@%@%ld",kServerAddress,circle_Share_Url,self._id];
//    }
//    NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
//    NSLog(@"content111:%@",self.content);
//    NSLog(@"_title11:%@",_title);
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:self.content
//                                       defaultContent:@""
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:_title
//                                                  url:shareURL
//                                          description:_content
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    [ShareSDK clientShareContent:publishContent
//                            type:shareType
//                   statusBarTips:YES
//                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                              
//                              
//                              if (state == SSPublishContentStateSuccess)
//                              {
////                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
//                                  [SVProgressHUD showSuccessWithStatus:@"分享成功"];;
//                                  if (isSelect) {
//                                      [self performSelector:@selector(sharedelay) withObject:nil afterDelay:0.5];
//                                  }
//                              }
//                              else if (state == SSPublishContentStateFail)
//                              {
////                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
//                                  if (isSelect) {
//                                      [self performSelector:@selector(sharedelay) withObject:nil afterDelay:1];
//                                  }
//                              }
//                          }];

}

-(void)sharedelay{
      [self shareWithShareType:KSina isSelectAll:NO];
}

+(void)initializePlat{
    
    [ShareSDK registerApp:AppKey_ShareSDK
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:AppKey_Sina
                                           appSecret:AppSecret_Sina
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:AppId_WeiXin
                                       appSecret:AppSecret_WeiXin];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:AppID_QQ
                                      appKey:AppSecre_QQ
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    
}

//新浪微博授权
+(void)authSinaWeibo{
  
    [ShareSDK authorize:SSDKPlatformTypeSinaWeibo settings: @{SSDKAuthSettingKeyScopes : @[@"follow_app_official_microblog"]} onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error description]];
            return ;
        }
        
        
        
        // 处理回调
        NSLog(@"user1:%@",user.credential.uid);
        NSLog(@"user2:%@",user.credential.token);
        NSLog(@"user3:%@",user.credential.secret);
        NSLog(@"user4:%@",user.nickname);
        NSLog(@"user5:%d",user.gender);
               NSLog(@"user6:%@",user.icon);
        NSLog(@"IdentifierForVendor:%@",IdentifierForVendor);
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:user.credential.uid,@"sid",user.nickname,@"userName",user.nickname,@"NickName",OS_Version,@"OS",IdentifierForVendor,@"DID",@"Sina",@"appType",@"",@"Descript", nil];
        [HttpConnection LoginSinaUser:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                    [SVProgressHUD dismiss];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeView"object:nil];
                }
                else{
                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
           
            
        }];
    }];
}

//qq
+(void)authQQLogin{
    NSArray *_permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    [ShareSDK authorize:SSDKPlatformTypeQQ settings: @{SSDKAuthSettingKeyScopes : _permissions} onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:[error description]];
            return ;
        }
        // 处理回调
        NSLog(@"user1:%@",user.credential.uid);
        NSLog(@"user2:%@",user.credential.token);
        NSLog(@"user3:%@",user.credential.secret);
        NSLog(@"user4:%@",user.nickname);
        NSLog(@"user5:%d",user.gender);
        NSLog(@"user6:%@",user.icon);
        NSLog(@"IdentifierForVendor:%@",IdentifierForVendor);
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:user.credential.uid,@"sid",user.nickname,@"userName",user.nickname,@"NickName", OS_Version,@"OS",IdentifierForVendor,@"DID",@"QQ",@"appType",@"",@"Descript", nil];
        [HttpConnection LoginQQUser:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeView"object:nil];
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                }
                else{
                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
            
        }];
    }];

}

+(void)authWeixinLogin{
//    NSArray *_permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
//    [ShareSDK authorize:SSDKPlatformTypeWechat settings: @{SSDKAuthSettingKeyScopes : _permissions} onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        if (error) {
//            [SVProgressHUD showErrorWithStatus:[error description]];
//            return ;
//        }
//        // 处理回调
//        NSLog(@"user1:%@",user.credential.uid);
//        NSLog(@"user2:%@",user.credential.token);
//        NSLog(@"user3:%@",user.credential.secret);
//        NSLog(@"user4:%@",user.nickname);
//        NSLog(@"user5:%d",user.gender);
//        NSLog(@"user6:%@",user.icon);
//        NSLog(@"IdentifierForVendor:%@",IdentifierForVendor);
//        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:user.credential.uid,@"sid",user.nickname,@"userName",user.nickname,@"NickName", OS_Version,@"OS",IdentifierForVendor,@"DID",@"WeChat",@"appType",@"",@"Descript", nil];
//        [HttpConnection LoginWeXinUser:dic WithBlock:^(id response, NSError *error) {
//            if (!error) {
//                if ([[response objectForKey:@"ok"] boolValue]) {
//                    [SVProgressHUD dismiss];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeView"object:nil];
//                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//                }
//                else{
//                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
//                }
//            }
//            else{
//                [SVProgressHUD showErrorWithStatus:ErrorMessage];
//            }
//            
//            
//        }];
//    }];
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"user：%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
                     NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:user.credential.uid,@"sid",user.nickname,@"userName",user.nickname,@"NickName", OS_Version,@"OS",IdentifierForVendor,@"DID",@"WeChat",@"appType",@"",@"Descript", nil];
                     [HttpConnection LoginWeXinUser:dic WithBlock:^(id response, NSError *error) {
                         if (!error) {
                             if ([[response objectForKey:@"ok"] boolValue]) {
                                 [SVProgressHUD dismiss];
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"goHomeView"object:nil];
                                 [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                             }
                             else{
                                 [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
                             }
                         }
                         else{
                             [SVProgressHUD showErrorWithStatus:ErrorMessage];
                         }
                         
                         
                     }];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];

}
@end

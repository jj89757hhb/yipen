//
//  Constants.h
//非常重要,上线之前这里一定要改成2，推送的环境变量 1、开发环境  2、生产环境
#define kDistributionTag                (2)//1为开发环境  2为生产环境
//测试环境
#define kServerAddress                   (kDistributionTag == 1 ? @"http://112.74.124.35/Api/": @"http://112.74.124.35/Api/")
#define  kTimeOutInterval 10

#define Register_Agreement_url @"http://www.ec54.com:8000/agreement/register"
static NSString *shareUrl=@"http://www.edianshang.com";

#define SeparatedByString @"[^begin^]"//帖子图片与文本的分割符号
#define SeparatedByString1 @"[^end^]"//帖子图片与文本的分割符号
#define Default_Image [UIImage imageNamed:@"logo_home"]
//#define SeparatedByString2 @"\" _src=\""//处理服务端字符
static NSString *ZFB_privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALG+0rEZCCVhudeoq2WqaHOxWeOB14HRGK4CpWFGauiKaDGgaxw6JUCYuSZRIEmf9ksIqS2wPWJGjph1mN7xZf/6+V49xOkkJCfDTKqh+5TSD/JxrtLWqC99YXTNkFI+m0Ibivii7yNSbp6replnL0QUs6WD4HVJpYa/s6fg+Ns3AgMBAAECgYAyDtTVjYAuzvQA2X7T1gcutf7jxNiFtfamYxZia+uF7BzmBRDFVVbSd3CFawmV0pgRj7HdrSnMeKSGKXBRMVkRIwb2EhE8/JmnY+QGHofKhc73+ysfv4a8nNuGwAlTkb4KvjbRgntResMvTcocNwIWASlEvF0rVe/z7un/QWeV8QJBAOXw0BtgtISZ82xMUYHXp6+9RCgOh+It/lYF9aZ7DPF5zFVe8vJEFkqEpRbI/DcRPG/9wysLHpb0G7wtFPeym38CQQDF46/r5EDb3aWfgiTpMDbmk+acsUx1MuJO1/VU775mZLywMahFXyP4jPKJAmvH9nVWoc096bCzEENuMAIkx3xJAkBLTBmJ7ZgPmC5rd251e35RAUSRbXi362HPH7J6qu7pIH52MlqSVROLoXZCSNy217EX51yC+ugwfI2ciJLGLjnXAkBc6o/Lvx0FH4mI397c7xqYIZICuO0hiobgZl53RyqrgVlnkallCUsmhWfMFSrudTabOtXX4EZrjZNbxYb8Jf6hAkAU8U9Y/h0zUzKK8YcNDDzgpCuwd3onygTAB0Bh2ujwAWMa0RHNJWxd6dKmugmrxLjQomMgyHJG10PrD8WMPEa/";


/*宏方法*/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define XH_STRETCH_IMAGE(image, edgeInsets) [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch]
#define AppDelegateInstance ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define DEUBG 1
#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define ISBIGSYSTEM5 ([[[UIDevice currentDevice] systemVersion] floatValue]>=5.0)
#define ISBIGSYSTEM6 ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)
#define ISBIGSYSTEM7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define DEVID  [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#define BLUECOLOR  [SVGloble colorFromHexRGB:@"258f9c"]
#define GRAYCOLOR  [UIColor colorWithRed:(double)190/255.0f green:(double)190/255.0f blue:(double)190/255.0f alpha:1.0]
#define DEEPCOLOR  [UIColor colorWithRed:(double)105/255.0f green:(double)105/255.0f blue:(double)105/255.0f alpha:1.0]  
#define SEPERATECOLOR [UIColor colorWithRed:(double)237/255.0f green:(double)237/255.0f blue:(double)237/255.0f alpha:1.0]
#define CELLSELECTEDCOLOR [UIColor colorWithRed:(double)240/255.0f green:(double)246/255.0f blue:(double)248/255.0f alpha:1.0]
#define BLACKCOLOR [UIColor colorWithRed:(double)0/255.0f green:(double)0/255.0f blue:(double)0/255.0f alpha:1.0] 
#define WHITEColor [UIColor whiteColor]
#define RedColor   [UIColor redColor]

#define Line_Color [SVGloble colorFromHexRGB:@"cccccc"]
#define DEEPORANGECOLOR [SVGloble colorFromHexRGB:@"fa8400"]//橘红色
#define VIEWBACKCOLOR [SVGloble colorFromHexRGB:@"ededede"]//背景色
#define DEEPBLACK [SVGloble colorFromHexRGB:@"333333"]
#define MIDDLEBLACK [SVGloble colorFromHexRGB:@"666666"]
#define LIGHTBLACK [SVGloble colorFromHexRGB:@"999999"]
#define LIGHTBLUE [SVGloble colorFromHexRGB:@"1E90FF"]
#define Tree_BgColor [SVGloble colorFromHexRGB:@"f9f9f9"]
#define Tree_Line [SVGloble colorFromHexRGB:@"d6d4d3"]//
#define MIDDLESEPERATECOLOR  [SVGloble colorFromHexRGB:@"e1e1e1"]//线条颜色
#define BOTTOMSEPERATECOLOR  [SVGloble colorFromHexRGB:@"fa8400"]
//#define Blue_Color [SVGloble colorFromHexRGB:@"00a0e9"]//00a0e9
//#define UserName_Color [SVGloble colorFromHexRGB:@"666"]
#define Clear_Color [UIColor clearColor]
#define ReplyName_Color [SVGloble colorFromHexRGB:@"0050b1"]//回复名称的颜色 
#define Light_Blue [SVGloble colorFromHexRGB:@"66abb4"]//登录按钮-青蓝色
#define Blue_selectColor [SVGloble colorFromHexRGB:@"005c6f"]//选择
#define Gray_unselectColor [SVGloble colorFromHexRGB:@"b1b1b1"]//未选择
//#define Login_Lable_Color [SVGloble colorFromHexRGB:@"999999"]//登录文字label颜色，也是分割线的颜色
#define debugMethod() NSLog(@"%s", __func__)


#define IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_6_plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define Storyboard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define TapGes [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]

#define NotificationCenter [NSNotificationCenter defaultCenter]
//#define OS_Version [[UIDevice currentDevice] systemVersion]
#define OS_Version @"IOS"
#define IdentifierForVendor [[UIDevice currentDevice].identifierForVendor UUIDString]
//appstore下载地址
static NSString *appStore_url=@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/1029417431";
static NSString *user_explain_Url=@"http://imyipen.com/sysm.html";
static NSString *user_agreement_Url=@"http://imyipen.com/yhxy.html";

static float compressionQuality =0.5;//图片压缩系数

static CGFloat Top_Height=10;//头部分隔的高度（盆景列表）
//......枚举.......

//注册的账户类型
typedef enum {
    kPersonAccount = 0,         // 个人账号
    kEnterpriseAccount           // 企业账号
} EAccountType;


typedef enum{
    KNo_Sex=0, //未设置
    KMan,
    KWoman
   
}ESexType;

//好友关系
typedef enum{
    KMyself=-1,//自己
    KStranger=0,//陌生人
    KFans=1,//你关注了别人  （但是在成员列表中的意思是 别人关注我，恰好相反）
    KAttention,//别人关注了你
    KFriend
}EFriendType;


//分享平台
typedef enum{
    KSina=0,
    KWeiXin,//微信好友
    KWeiXin_Zone,//朋友圈
    KQQ,
    KQQ_Zone
    
}EShareType;

//同城发布类型
typedef enum{
    KSend_Activity=1,
    KSend_Store,
    KSend_YouYuan,
    KSend_XiangYuan,
    KSend_TuoGuan
}SameCitySendType;

//1-盆景、2-活动、3-店家、4-友园、5-享园、6-托管

typedef enum{
    KCollect_Penjin=1,
    KCollect_Activity,
    KCollect_DianJia,
    KCollect_YouYuan,
    KCollect_XiangYuan,
    KCollect_TuoGuan
    
}Collect_Type;

//议价或询价类型 当前状态 1-询价/议价 2-卖家报价3-买家议价4-卖家议价 5-买家最终裁决

typedef enum{
    KAsk_Price_buyer=1,
    KOffer_Price_Seller,
    KNegotiate_buyer,
    KNegotiate_Seller,
    KFinal_Price
}
Negotiate_Type;

//1-议价或回价 2-放弃3-同意 4-购买
typedef enum{
    KNegotiate=1,
    Kgiveup,
    KAgree,
    KBuy
}
Buy_Result;

//盆景类型
typedef enum{
    KSale=1,//销售
    KPaiMai//拍卖
}PenJin_Type;

//支付方式
typedef enum{
    KYuE_Pay=0,//余额支付
    KZFB_Pay,
    KWeiXin_Pay
    
}Pay_Type;


//----第三方使用的key Secret-----
#define RONGCLOUD_IM_APPKEY @"8brlm7ufrnor3"//融云
#define DEFAULTS [NSUserDefaults standardUserDefaults]



static NSString *AppKey_ShareSDK =@"fb8559f7b43c";
static NSString *AppSecret_ShareSDK =@"4f6280818e441cc004866b181602256d";
//新浪
static NSString *AppKey_Sina =@"2816195495";
static NSString *AppSecret_Sina =@"d3ebadb7351c3eb755323cfbca9952ee";
//qq
static NSString *AppID_QQ =@"1105169421";
static NSString *AppSecre_QQ=@"8lqOaBGu1tNNwMI2";

//微信
static NSString *AppId_WeiXin=@"wxc854949473b2b966";
static NSString *AppSecret_WeiXin=@"7b72fec8cb9947e4d40339506fe4c7b4";

//百度地图
static NSString *AppKey_BaiduMap=@"8AR0tFGYDwRRqYNoX1kB66Yc";

//....userDefault...
//static NSString *KPhone                        =@"KPhone";
//static NSString *KUserId                       =@"KUserId";
//static NSString *KUserName                     =@"KUserName";
//static NSString *KNickName                     =@"KNickName";
//static NSString *Kavatar_sign                   =@"avatar_sign";

//....通知名称....
static NSString *KRegister                     =@"KRegister";//注册
static NSString *KGetVerificationCode          =@"KGetVerificationCode";//获取验证码
static NSString *KLogin                        =@"KLogin";//登录
static NSString *KResetPsw                      =@"KResetPsw";//重置密码
static NSString *KModifyPsw                      =@"KModifyPsw";//修改密码
static NSString *KloginOutNotify         =@"KloginOutNotify";//退出登录



//....有关提示语的字符串....
static NSString *ErrorMessage         =@"网络不给力";
static NSString *CodeSuccessMessage   =@"验证码已成功发送到您的手机，请耐心等待...";
static NSString *WaitMessage          =@"请稍候...";
static NSString *AttentionSuccess     =@"关注成功";
static NSString *DeleteAttentionSuccess =@"已取消关注";
static NSString *CollectSuccess     =@"收藏成功";
static NSString *DeleteCollectSuccess =@"已取消收藏";

//userdefault 的key
static NSString *Mobile        =@"Mobile";
static NSString *UserNickName  =@"userNickName";
static NSString *UserId =@"userId";
static NSString *UserPwd=@"userPwd";
static NSString *UserPortraitUri=@"userPortraitUri";
static NSString *KErrorMsg=@"errorMsg";//接口数据返回的错误信息
static NSString *KDataList=@"KDataList";//接口数据返回


static NSInteger Max_Pic=5;

//字典的key  盆景分类
static NSString *SenShu=@"Domestic";
static NSString *LeiBie=@"Category";
static NSString *ChanDi=@"Origin";
static NSString *PinZhong=@"Varieties";
static NSString *ShuXin=@"Model";
static NSString *ChiCun=@"Size";
static NSString *QiTa=@"Other";

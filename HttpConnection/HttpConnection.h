//
//  HttpConnection.h
//  panjing
//
//  Created by 华斌 胡 on 16/1/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConnection : NSObject{
    
}
//注册用户-获取验证码
+(void)registerUserOfGetCodeWithDic:(NSDictionary*)dic WithBlock:(void (^)(id response, NSError *error))block;
+(void)registerUserWithDic:(NSDictionary *)dic WithBlock:(void (^)(id response, NSError *error))block;
+(void)loginWithPhone:(NSDictionary*)dic WithBlock:(void (^)(id response, NSError *error))block;
+(void)RegisterSinaUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)editUserInfoWithParameter:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block;
+(void)getOwnerInfoWithParameter:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString ;
+(void)GetMyShareList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)getDownCityWithParameter:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)postSameCityInfos:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block;
+(void)getActivtyList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetStoreList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)SetPayPassword:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)topUp:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)withDrawal:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMySale:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyBuy:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyAuction:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyPurchase:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)Focus:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;

+(void)Comments:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;

+(void)Collection:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)DelCollect:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)Praised:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)getCodeOfPayPsw:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)MemberCertifiPicture:(id)parameter pic1:(NSData*)pic1 pic2:(NSData*)pic2 pic3:(NSData*)pic3 count:(int)count WithBlock:(void (^)(id response, NSError *error))block;
+(void)MemberCertifiInfo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)DownBaseInfo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PostBasins:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block;
+(void)PostBasins2:(id)parameter pics:(NSData*)pic WithBlock:(void (^)(id response, NSError *error))block;
+(void)PostBasinsFate:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block;
+(void)AddAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)EditAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)DefaultAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)DelAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetAddressList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)LoginSinaUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)LoginQQUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)LoginWeXinUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;

+(void)FindPwd:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)FindPwdTwo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetBonsaiList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyBonsaiDoctor:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetFriendsList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetShareGardenList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetHostingGardenList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetFocus:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetFans:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PostAuction:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetAuctionRecord:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PostBargaining:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetBargainingRecord:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)SendTrad:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block
;
+(void)PostBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;

+(void)GetMyCollect:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)JoinActivity:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;

+(void)getToken:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetMyJoinBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetTradingDetail:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetExperts:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)GetComment:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PaySuccess:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)WeChatPay:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)AliPay:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)ShippingAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PutCourier:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)DelMyShare:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
+(void)PayPwdAuthe:(id)parameter WithBlock:(void (^)(id response, NSError *error))block;
@end

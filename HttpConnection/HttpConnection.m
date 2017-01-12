
//
//  HttpConnection.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "HttpConnection.h"
#import "AFAppDotNetAPIClient.h"
//#import "JSONKit.h"
#import "SBJson4.h"
#import "YPUserInfo.h"
#import "DataSource.h"
#import "PenJinInfo.h"
#import "AuctionRecord.h"
#import "CommentInfo.h"
#import "ActivityInfo.h"
#import "ExchangeInfo.h"
#import "FundDetail.h"
#import "BDetail.h"
@implementation HttpConnection
/**
 *  获取验证码
 *
 *  @param dic   <#dic description#>
 *  @param block <#block description#>
 */
+(void)registerUserOfGetCodeWithDic:(NSDictionary *)dic WithBlock:(void (^)(id response, NSError *error))block{

    NSString *getUrl=[NSString stringWithFormat:@"%@service.asmx/RegOne",kServerAddress];
    NSString *bodyStr=[NSString stringWithFormat:@"Mobile=%@" ,dic[@"Mobile"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval=kTimeOutInterval;
    // 设置
    [request setURL:[NSURL URLWithString:getUrl]];
    [request setHTTPMethod:@"POST"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    NSData *body=[bodyStr dataUsingEncoding:NSUTF8StringEncoding ];
    [request setHTTPBody:body];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"registerUserOfGetCodeWithDic: %@", response);
            dispatch_sync(dispatch_get_main_queue(), ^{
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dict];
                [DataSource sharedDataSource].userInfo=userInfo;
                if (block) {
                    block(dict,nil);
                }
            });
            
        }
        else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (block) {
                    block(nil,connectionError);
                }
            });
        }
    }];


}

+(void)registerUserWithDic:(NSDictionary *)dic WithBlock:(void (^)(id response, NSError *error))block{
    NSString *getUrl=[NSString stringWithFormat:@"%@service.asmx/RegTwo",kServerAddress];
    NSString *bodyStr=[NSString stringWithFormat:@"Mobile=%@&Pwd=%@" ,dic[@"Mobile"],dic[@"Pwd"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval=kTimeOutInterval;
    // 设置
    [request setURL:[NSURL URLWithString:getUrl]];
    [request setHTTPMethod:@"POST"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    NSData *body=[bodyStr dataUsingEncoding:NSUTF8StringEncoding ];
    [request setHTTPBody:body];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"registerUserWithDic: %@", response);
            dispatch_sync(dispatch_get_main_queue(), ^{
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dict];
                [DataSource sharedDataSource].userInfo=userInfo;
                if (block) {
                    block(dict,nil);
                }
            });
            
        }
        else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (block) {
                    block(nil,connectionError);
                }
            });
        }
    }];

    
}

//手机号登录
+(void)loginWithPhone:(NSDictionary*)dic WithBlock:(void (^)(id response, NSError *error))block{
     NSString *getUrl=[NSString stringWithFormat:@"%@service.asmx/Login",kServerAddress];
      NSString *bodyStr=[NSString stringWithFormat:@"Mobile=%@&Pwd=%@&DID=%@&OS=%@" ,dic[@"Mobile"],dic[@"Pwd"],dic[@"DID"],dic[@"OS"]];
//    NSString *json=[self dictionaryToJson:dic];
//    [[AFAppDotNetAPIClient sharedClient] GET:getUrl parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSLog(@"登录:%@",responseObject);
//        if (block) {
//            block(responseObject,nil);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (block) {
//            block(nil,error);
//        }
//    }];
//    return;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval=kTimeOutInterval;
    // 设置
    [request setURL:[NSURL URLWithString:getUrl]];
    [request setHTTPMethod:@"POST"];
//    [request setValue:host forHTTPHeaderField:@"Host"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    NSData *body=[bodyStr dataUsingEncoding:NSUTF8StringEncoding ];
    [request setHTTPBody:body];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            BOOL isOK= [NSJSONSerialization isValidJSONObject:data];
//            SBJson4Parser *jsonParser = [[SBJson4Parser alloc] init];
//         NSDictionary *resultDict = [data objectFromJSONData];
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"loginWithPhone: %@", response);
            dispatch_sync(dispatch_get_main_queue(), ^{
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dict];
                [DataSource sharedDataSource].userInfo=userInfo;
                [DEFAULTS setObject:userInfo.ID forKey:UserId];
                [DEFAULTS setObject:userInfo.NickName forKey:UserNickName];
                [DEFAULTS setObject:userInfo.UserHeader forKey:UserPortraitUri];
                if (userInfo.Mobile.length) {
                    [DEFAULTS setObject:userInfo.Mobile forKey:Mobile];
                }
                [DEFAULTS synchronize];
            if (block) {
                block(dict,nil);
            }
            });
            
        }
        else{
              dispatch_sync(dispatch_get_main_queue(), ^{
            if (block) {
                block(nil,connectionError);
            }
              });
        }
    }];
}

//新浪用户登录
+(void)LoginSinaUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@Service.asmx/LoginOtherUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"LoginSinaUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        if (json) {
            YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:json];
            [DataSource sharedDataSource].userInfo=userInfo;
            [DEFAULTS setObject:userInfo.ID forKey:UserId];
            [DEFAULTS setObject:userInfo.NickName forKey:UserNickName];
            [DEFAULTS setObject:userInfo.UserHeader forKey:UserPortraitUri];
            [DEFAULTS synchronize];
        }
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//qq用户登录
+(void)LoginQQUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/LoginOtherUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"LoginQQUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        if (json) {
            YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:json];
            [DataSource sharedDataSource].userInfo=userInfo;
            [DEFAULTS setObject:userInfo.ID forKey:UserId];
            [DEFAULTS setObject:userInfo.NickName forKey:UserNickName];
            [DEFAULTS setObject:userInfo.UserHeader forKey:UserPortraitUri];
            [DEFAULTS synchronize];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//微信用户登录
+(void)LoginWeXinUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/LoginOtherUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"LoginWeXinUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"LoginWeXinUser：%@",json);
        if (json) {
            YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:json];
            [DataSource sharedDataSource].userInfo=userInfo;
            [DEFAULTS setObject:userInfo.ID forKey:UserId];
            [DEFAULTS setObject:userInfo.NickName forKey:UserNickName];
            [DEFAULTS setObject:userInfo.UserHeader forKey:UserPortraitUri];
            [DEFAULTS synchronize];
        }
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//新浪微博注册
+(void)RegisterSinaUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/RegisterSinaUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RegisterSinaUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//qq用户注册
+(void)RegisterQQUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/RegisterQQUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RegisterQQUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//微信用户注册
+(void)RegisterWeXinUser:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/RegisterWeXinUser",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RegisterWeXinUser：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}





//编辑资料
+(void)editUserInfoWithParameter:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block{
    
//     NSString *getUrl=[NSString stringWithFormat:@"%@HandlerEditOwner.ashx/EditOwner",kServerAddress];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    request.timeoutInterval=kTimeOutInterval;
//    // 设置
//    [request setURL:[NSURL URLWithString:getUrl]];
//    [request setHTTPMethod:@"POST"];
//    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
//    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
//    NSData *body=[parameter dataUsingEncoding:NSUTF8StringEncoding ];
//    [request setHTTPBody:body];
//    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if (!connectionError) {
//            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"editUserInfoWithParameter: %@", response);
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dict];
////                [DataSource sharedDataSource].userInfo=userInfo;
//                if (block) {
//                    block(dict,nil);
//                }
//            });
//            
//        }
//        else{
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                if (block) {
//                    block(nil,connectionError);
//                }
//            });
//        }
//    }];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@HandlerEditOwner.ashx/EditOwner",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss.SSS";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        for (int i=0;i<pics.count;i++) {
            NSData *imageData=pics[i];
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
            NSLog(@"fileName111:%@",fileName);
            // 上传图片，以文件流的格式
            NSString *name=@"UserHeader";
//             NSString *name=@"File";
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"editUserInfoWithParameter：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        if (json) {
//            YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:json];
//            [DataSource sharedDataSource].userInfo=userInfo;
        }

        NSLog(@"json：%@",json);
        block(json,nil);
//        if ([responseObject isKindOfClass:[NSData class]]) {
//            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"response：%@",response);
//        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//获取个人信息页
+(void)getOwnerInfoWithParameter:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    NSString *getUrl=[NSString stringWithFormat:@"%@service.asmx/GetOwnerInfo",kServerAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval=kTimeOutInterval;
    // 设置
    [request setURL:[NSURL URLWithString:getUrl]];
    [request setHTTPMethod:@"POST"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    NSData *body=[parameter dataUsingEncoding:NSUTF8StringEncoding ];
    [request setHTTPBody:body];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"getOwnerInfoWithParameter: %@", response);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (!dict) {
                    NSLog(@"服务端错误");
                    NSError *error=[[NSError alloc] init];
                    if (block) {
                        block(nil,error);
                    }
                    return ;
                }
                NSDictionary *user=dict[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                [DataSource sharedDataSource].userInfo=userInfo;
                NSLog(@"idddd:%@",userInfo.ID);
                NSLog(@"UserHeader:%@",userInfo.UserHeader);
                if (block) {
                    block(dict,nil);
                }
            });
            
        }
        else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (block) {
                    block(nil,connectionError);
                }
            });
        }
    }];

}

//关注
+(void)Focus:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/Focus",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Focus：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"Focusjson：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//取消关注
+(void)CancelFocus:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/CancelFocus",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Focus：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"CancelFocus：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//删除我发布的
+(void)DelMyPost:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DelMyPost",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Focus：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"DelMyPost：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}



//评论
+(void)Comments:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/Comments",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Comments：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//收藏
//1-盆景、2-活动、3-店家、4-友园、5-享园、6-托管
+(void)Collection:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/Collection",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//取消收藏
+(void)DelCollect:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DelCollect",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"DelCollect：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"DelCollect：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//参加活动
+(void)JoinActivity:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/JoinActivity",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"DelCollect：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"JoinActivity：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//退出活动
+(void)ExitActivity:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/ExitActivity",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"DelCollect：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"ExitActivity：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}



//赞  //1-盆景、2-活动、3-店家、4-友园、5-享园、6-托管
+(void)Praised:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/Praised",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"Praised：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//取消点赞
+(void)CancelPraised:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/CancelPraised",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"CancelPraised：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//获取账户资金明细
+(void)GetTradingDetail:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetTradingDetail",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetTradingDetail：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                
                FundDetail  *info=[[FundDetail alloc] initWithKVCDictionary:dic];
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//议价、询价
+(void)PostBargaining:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PostBargaining",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PostBargaining：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//余额支付密码验证
+(void)PayPwdAuthe:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PayPwdAuthe",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PayPwdAuthe：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];

}

//获取交易小助手
+(void)GetBargainingRecord:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetBargainingRecord",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetBargainingRecord：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];//盆景实体
                NSArray *Attach=Bonsai[@"attach"];
                
                NSArray *bDetails=dic[@"BDetail"];
                NSMutableArray *_bDetails=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in bDetails) {
                    BDetail *detail =[[BDetail alloc] initWithKVCDictionary:dic];
                    [_bDetails addObject:detail];
                }
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                NSDictionary *BuyUser=dic[@"BuyUser"];
                NSDictionary *SaleUser=dic[@"SaleUser"];
                YPUserInfo *buyUser=[[YPUserInfo alloc] initWithKVCDictionary:BuyUser];
                YPUserInfo *saleUser=[[YPUserInfo alloc] initWithKVCDictionary:SaleUser];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
//                NSDictionary *user=dic[@"user"];
//                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                ExchangeInfo *exchange=[[ExchangeInfo alloc] initWithKVCDictionary:dic];
                exchange.BuyUser=buyUser;
                exchange.SaleUser=saleUser;
                exchange.BDetails=_bDetails;
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                exchange.Bonsai=info;
//                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:exchange];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//改变订单状态
+(void)SendTrad:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/SendTrad",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"SendTrad：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
       
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}



//获取评论
+(void)GetComment:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetComment",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetComment：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Comment"];//盆景实体
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                NSDictionary *CommUser=dic[@"CommUser"];//评论用户
                NSDictionary *PostUser=dic[@"PostUser"];//原贴用户
                YPUserInfo *commUser=[[YPUserInfo alloc] initWithKVCDictionary:CommUser];
                YPUserInfo *postUser=[[YPUserInfo alloc] initWithKVCDictionary:PostUser];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                //                NSDictionary *user=dic[@"user"];
                //                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
//                ExchangeInfo *exchange=[[ExchangeInfo alloc] initWithKVCDictionary:dic];
//                exchange.BuyUser=buyUser;
//                exchange.SaleUser=saleUser;
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                info.CommUser=commUser;
                info.PostUser=postUser;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//支付完成后调用
+(void)PaySuccess:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PaySuccess",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PaySuccess：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
           
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//微信支付
+(void)WeChatPay:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/WeChatPay",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"WeChatPay：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//支付宝预付
+(void)AliPay:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/AliPay",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"AliPay：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//ShippingAddress  上传订单的收货地址
+(void)ShippingAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/ShippingAddress",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"ShippingAddress：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}

//提交快递
+(void)PutCourier:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PutCourier",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PutCourier：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}


//删除分享
+(void)DelMyShare:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DelMyShare",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"Collection：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"DelMyShare：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            
            block(json,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
}



//获取分享列表
+(void)GetMyShareList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyShare",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"GetBonsaiList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyShareList：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
//                NSDictionary *user=dic[@"user"];
//                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                YPUserInfo *userInfo=[[YPUserInfo alloc] init];
                if ([parameter[@"UID"] isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {
                     userInfo=[DataSource sharedDataSource].userInfo;//补充“我的分享” 的用户数据
                }
         
//                userInfo.NickName=[DataSource sharedDataSource].userInfo.NickName;
//                userInfo.ID=[DataSource sharedDataSource].userInfo.ID;
//                userInfo.UserHeader=[DataSource sharedDataSource].userInfo;
                
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取城市
+(void)getDownCityWithParameter:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    NSString *getUrl=[NSString stringWithFormat:@"%@service.asmx/DownCity",kServerAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval=kTimeOutInterval;
    // 设置
    [request setURL:[NSURL URLWithString:getUrl]];
    [request setHTTPMethod:@"POST"];
    NSString *contentLength = [NSString stringWithFormat:@"%ld", [getUrl length]];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    NSData *body=[parameter dataUsingEncoding:NSUTF8StringEncoding ];
    [request setHTTPBody:body];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"getDownCityWithParameter: %@", response);
            dispatch_sync(dispatch_get_main_queue(), ^{
                //                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dict];
                //                [DataSource sharedDataSource].userInfo=userInfo;
                if (block) {
                    block(dict,nil);
                }
            });
            
        }
        else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (block) {
                    block(nil,connectionError);
                }
            });
        }
    }];
    

    
}

//发布同城信息
+(void)postSameCityInfos:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@HandlerPostInfos.ashx/PostInfos",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss.SSS";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        for (int i=0;i<pics.count;i++) {
            NSData *imageData=pics[i];
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
            NSLog(@"fileName111:%@",fileName);
            // 上传图片，以文件流的格式
            NSString *name=[NSString stringWithFormat:@"File%d",i+1];
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"创建活动数据返回成功了：%@",responseObject);
//        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
                        json=  [NSJSONSerialization
                                JSONObjectWithData:responseObject
                                options:NSJSONReadingMutableContainers
                                error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"response：%@",response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];

}

//获取活动列表
+(void)getActivtyList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetActivtyList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"获取活动列表：%@",responseObject);
//        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"getActivtyList：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Activty"];
                NSArray *Attach=Bonsai[@"Attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
//                NSArray *Praised=Bonsai[@"Praised"];
                NSArray *Praised=Bonsai[@"joiners"];//活动参加者
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];

   
}

//获取店家列表页
+(void)GetStoreList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetStoreList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"获取活动列表：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetStoreList：%@",json);
        //        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"store"];
                NSArray *Attach=Bonsai[@"Attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取盆景列表页
+(void)GetBonsaiList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetBonsaiList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetBonsaiList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetBonsaiList：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                        [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
           
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                
                NSArray *_experts=Bonsai[@"experts"];
                NSMutableArray *experts=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in _experts) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [experts addObject:userInfo];
                }
                
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                info.experts=experts;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
             block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
             block(dic,nil);
        }
       
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取我的盆大夫
+(void)GetMyBonsaiDoctor:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyBonsaiDoctor",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"GetBonsaiList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyBonsaiDoctor：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                NSArray *_experts=Bonsai[@"experts"];
                NSMutableArray *experts=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in _experts) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [experts addObject:userInfo];
                }
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                info.experts=experts;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}



//获取友园列表页
+(void)GetFriendsList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetFriendsList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetFriendsList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetFriendsList：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"gardens"];
                NSArray *Attach=Bonsai[@"Attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取享园列表页
+(void)GetShareGardenList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetShareGardenList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetShareGardenList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetShareGardenList：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"gardens"];
                NSArray *Attach=Bonsai[@"Attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取托管列表页
+(void)GetHostingGardenList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetHostingGardenList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetHostingGardenList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
              NSLog(@"GetHostingGardenList：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"gardens"];
                NSArray *Attach=Bonsai[@"Attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//设置支付密码
+(void)SetPayPassword:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/SetPayPassword",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SetPayPassword：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//充值

+(void)topUp:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/TopUp",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"topUp：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//提现

+(void)withDrawal:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/withDrawal",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"withDrawal：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取我卖的记录

+(void)GetMySale:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMySale",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetMySale：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];//盆景实体
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                NSDictionary *BuyUser=dic[@"BuyUser"];
                NSDictionary *SaleUser=dic[@"SaleUser"];
                YPUserInfo *buyUser=[[YPUserInfo alloc] initWithKVCDictionary:BuyUser];
                YPUserInfo *saleUser=[[YPUserInfo alloc] initWithKVCDictionary:SaleUser];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                //                NSDictionary *user=dic[@"user"];
                //                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                ExchangeInfo *exchange=[[ExchangeInfo alloc] initWithKVCDictionary:dic];
                exchange.BuyUser=buyUser;
                exchange.SaleUser=saleUser;
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                exchange.Bonsai=info;
                //                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:exchange];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取我买的记录

+(void)GetMyBuy:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyBuy",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetMyBuy：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                NSDictionary *Bonsai=dic[@"Bonsai"];//盆景实体
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                NSDictionary *BuyUser=dic[@"BuyUser"];
                NSDictionary *SaleUser=dic[@"SaleUser"];
                YPUserInfo *buyUser=[[YPUserInfo alloc] initWithKVCDictionary:BuyUser];
                YPUserInfo *saleUser=[[YPUserInfo alloc] initWithKVCDictionary:SaleUser];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                //                NSDictionary *user=dic[@"user"];
                //                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                ExchangeInfo *exchange=[[ExchangeInfo alloc] initWithKVCDictionary:dic];
                exchange.BuyUser=buyUser;
                exchange.SaleUser=saleUser;
                
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                exchange.Bonsai=info;
                //                info.userInfo=userInfo;
                info.Attach=pics;
                info.Comment=commentList;
                info.Praised=Praiseds;
                [dataList addObject:exchange];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取拍卖纪录
+(void)GetMyAuction:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyAuction",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetMyAuction：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyAuction：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取拍买的记录
+(void)GetMyPurchase:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyPurchase",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"GetMyPurchase：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyPurchase：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取收藏
+(void)GetMyCollect:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyCollect",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"GetMyPurchase：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyCollect：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
//                NSDictionary *Bonsai=dic[@"Bonsai"];
                NSDictionary *Bonsai=dic;
                NSArray *Attach=Bonsai[@"attach"];
                NSMutableArray *pics=[[NSMutableArray alloc] init];
                for (NSDictionary *picDic in Attach) {
                    [pics addObject:[picDic objectForKey:@"Path"]];
                }
                NSArray *comments=Bonsai[@"Comment"];
                NSMutableArray *commentList=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in comments) {
                    CommentInfo *comment=[[CommentInfo alloc] initWithKVCDictionary:dic];
                    [commentList addObject:comment];
                }
                
                NSArray *Praised=Bonsai[@"Praised"];
                NSMutableArray *Praiseds=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in Praised) {
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                    [Praiseds addObject:userInfo];
                }
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                if ([parameter[@"Type"] integerValue]==KCollect_Penjin) {
                    PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:Bonsai];
                    info.userInfo=userInfo;
                    info.Attach=pics;
                    info.Comment=commentList;
                    info.Praised=Praiseds;
                    [dataList addObject:info];
                }
                else if([parameter[@"Type"] integerValue]==KCollect_Activity||[parameter[@"Type"] integerValue]==KCollect_DianJia||[parameter[@"Type"] integerValue]==KCollect_YouYuan||[parameter[@"Type"] integerValue]==KCollect_XiangYuan||[parameter[@"Type"] integerValue]==KCollect_TuoGuan){
                    ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:Bonsai];
                    info.userInfo=userInfo;
                    info.Attach=pics;
                    info.Comment=commentList;
                    info.Praised=Praiseds;
                    [dataList addObject:info];
                }
              
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}



//设置支付密码 获取验证码
+(void)getCodeOfPayPsw:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetVodeForPay",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//个人认证 （先传图片）
+(void)MemberCertifiPicture:(id)parameter pic1:(NSData*)pic1 pic2:(NSData*)pic2 pic3:(NSData*)pic3 count:(int)count WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *url=[NSString stringWithFormat:@"%@HandlerMemberCertifi.ashx/MemberCertifi",kServerAddress];
      NSString *url=[NSString stringWithFormat:@"%@HandlerPostCertifiAttach.ashx",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss.SSS";

        if (pic1&&count==1) {
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSLog(@"fileName1:%@",fileName);
            // 上传图片，以文件流的格式
//            NSString *name=[NSString stringWithFormat:@"IDCardPositive"];
            NSString *name=[NSString stringWithFormat:@"BusinessLicense"];
            //
            [formData appendPartWithFileData:pic1 name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        if (pic2&&count==2){
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSLog(@"fileName2:%@",fileName);
            // 上传图片，以文件流的格式
//            NSString *name=[NSString stringWithFormat:@"IDCardOpposite"];
            NSString *name=[NSString stringWithFormat:@"BusinessLicense"];
            [formData appendPartWithFileData:pic2 name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        if (pic3&&count==3) {
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSLog(@"fileName3:%@",fileName);
            // 上传图片，以文件流的格式
//            NSString *name=[NSString stringWithFormat:@"BusinessLicense"];
             NSString *name=[NSString stringWithFormat:@"BusinessLicense"];
            [formData appendPartWithFileData:pic3 name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"MemberCertifi：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
//        NSLog(@"json：%@",json);
        block(json,nil);
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"MemberCertifiPicture：%@",response);
//         block(response,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//个人认证 传基本信息
+(void)MemberCertifiInfo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@HandlerMemberCertifi.ashx/MemberCertifi",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"MemberCertifiInfo：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"MemberCertifiInfo：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}



//基础数据下载
+(void)DownBaseInfo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DownBaseInfo",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"DownBaseInfo：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//上盘(分享、出售、拍卖、盆大夫 第二部提交图片)
//+(void)PostBasins2:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block{
+(void)PostBasins2:(id)parameter pics:(NSData*)pic WithBlock:(void (^)(id response, NSError *error))block{
    //HandlerPostBasinsAttach.ashx
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *url=[NSString stringWithFormat:@"%@HandlerPostBasins.ashx/PostBasins",kServerAddress];
    NSString *url=[NSString stringWithFormat:@"%@HandlerPostBasinsAttach.ashx/HandlerPostBasinsAttach",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss.SSS";
        //        NSString *str = [formatter stringFromDate:[NSDate date]];
        //        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//        for (int i=0;i<pics.count;i++) {
            NSData *imageData=pic;
           int x = arc4random() % 100;//加个随机数
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
//            NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
        NSString *fileName = [NSString stringWithFormat:@"%@_%d.png", str,x];
            NSLog(@"fileName111:%@",fileName);
            // 上传图片，以文件流的格式
//            NSString *name=[NSString stringWithFormat:@"File%d",i+1];
              NSString *name=[NSString stringWithFormat:@"file"];
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
//        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json2：%@",json);
        block(json,nil);
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"PostBasins2：%@",response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}


//上盘(分享、出售、拍卖、盆大夫 第一步 提交清单数据)
+(void)PostBasins:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block{
    //HandlerPostBasinsAttach.ashx
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@HandlerPostBasins.ashx/HandlerPostBasins",kServerAddress];
    //    NSString *url=[NSString stringWithFormat:@"%@HandlerPostBasinsAttach.ashx/PostBasins",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"PostBasins：%@",response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}


//上盘缘
+(void)PostBasinsFate:(id)parameter pics:(NSMutableArray*)pics WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@HandlerPostBasinsFate.ashx/PostBasinsFate",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss.SSS";
        //        NSString *str = [formatter stringFromDate:[NSDate date]];
        //        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        for (int i=0;i<pics.count;i++) {
            NSData *imageData=pics[i];
            NSString *str = [formatter stringFromDate:[NSDate date]];
            str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png", str,i];
            NSLog(@"fileName111:%@",fileName);
            // 上传图片，以文件流的格式
            NSString *name=[NSString stringWithFormat:@"File%d",i+1];
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"创建活动数据返回成功了：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"PostBasins：%@",response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}


//添加地址
+(void)AddAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/AddAddress",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"AddAddress：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//修改地址
+(void)EditAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/EditAddress",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"EditAddress：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//设置默认地址
+(void)DefaultAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DefaultAddress",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"DefaultAddress：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//删除地址
+(void)DelAddress:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/DelAddress",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"DelAddress：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}



//获取地址
+(void)GetAddressList:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetAddressList",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"GetAddressList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"json：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


+(void)FindPwd:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/FindPwd",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"FindPwd：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


+(void)FindPwdTwo:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/FindPwdTwo",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"FindPwd：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//出价
+(void)PostAuction:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PostAuction",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PostAuction：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取拍卖出价记录
+(void)GetAuctionRecord:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetAuctionRecord",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetAuctionRecord：%@",json);
//        block(json,nil);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                
                AuctionRecord *auction=[[AuctionRecord alloc] initWithKVCDictionary:dic];
                auction.userInfo=userInfo;
                [dataList addObject:auction];
                
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}




//获取关注用户列表
+(void)GetFocus:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetFocus",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"GetBonsaiList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetFocus：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                userInfo.IsFocus=@"1";//服务端未返回 自己补充
                [dataList addObject:userInfo];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取粉丝列表
+(void)GetFans:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetFans",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"GetBonsaiList：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetFans：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
                [dataList addObject:userInfo];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取盆缘
+(void)GetBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetBonsaiFate",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetBonsaiFate：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
                        NSArray *list=json[@"Bonsai"];
                        NSMutableArray *dataList=[[NSMutableArray alloc] init];
                        for (NSDictionary *dic in list) {
//                            NSDictionary *Bonsai=dic[@"Bonsai"];
                   
            
            
//                            NSDictionary *user=dic[@"user"];
//                            YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
            
                            PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:dic];
//                            info.userInfo=userInfo;
                            [dataList addObject:info];
            
                        }
                        NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
                        block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}


//获取我的盆缘
+(void)GetMyBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyBonsaiFate",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyBonsaiFate：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:dic];
                                            info.userInfo=userInfo;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

 
//	获取我参与的盆缘信息
+(void)GetMyJoinBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetMyJoinBonsaiFate",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetMyJoinBonsaiFate：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                
                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:user];
                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:dic];
                info.userInfo=userInfo;
                [dataList addObject:info];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//盆缘(喜欢、不喜欢)
+(void)PostBonsaiFate:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PostBonsaiFate",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PostBonsaiFate：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//发布活动
+(void)PostActivityInfos:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PostActivityInfos",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PostBonsaiFate：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}

//获取专家
+(void)GetExperts:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/GetExperts",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"GetExperts：%@",json);
        if ([[json objectForKey:@"ok"] boolValue]) {
            NSArray *list=json[@"records"];
            NSMutableArray *dataList=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in list) {
                
//                NSDictionary *user=dic[@"user"];
                YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:dic];
//                PenJinInfo *info=[[PenJinInfo alloc] initWithKVCDictionary:dic];
//                info.userInfo=userInfo;
                [dataList addObject:userInfo];
                
            }
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:dataList,KDataList ,nil];
            block(dic,nil);
        }
        else{
            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:json[@"reason"],KErrorMsg ,nil];
            block(dic,nil);
        }
        
//        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}



//融云服务器获取token
+(void)getToken:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"https://api.cn.ronghub.com/user/getToken"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"getCodeOfPayPsw：%@",responseObject);
        //        NSDictionary* json = responseObject;
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"getToken：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
    
}
//获取是否版本在验收阶段
+(void)IsApplePay:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/IsApplePay",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"IsApplePay：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];

}

//个人会员支付完成  废弃了
+(void)PayPerMember:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PayPerMember",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PayPerMember：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//商家会员支付完成 废弃了
+(void)PayBusinessMember:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/PayBusinessMember",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"PayBusinessMember：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//会员支付完成后调用（余额支付）
+(void)MemberPaySuccess:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/MemberPaySuccess",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"MemberPaySuccess：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}


//修改密码
+(void)ChangePwd:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/ChangePwd",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"ChangePwd：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//修改绑定手机
+(void)BindMobile:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/BindMobile",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"BindMobile：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//修改绑定手机后、修改密码
+(void)SetPwd:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/SetPwd",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"SetPwd：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}

//设置提现账户
+(void)SetWDAccount:(id)parameter WithBlock:(void (^)(id response, NSError *error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@service.asmx/SetWDAccount",kServerAddress];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameter error:nil];
    [request setTimeoutInterval:kTimeOutInterval];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* json=nil;
        NSError *error=nil;
        if (responseObject) {
            json=  [NSJSONSerialization
                    JSONObjectWithData:responseObject
                    options:NSJSONReadingMutableContainers
                    error:&error];
        }
        NSLog(@"SetWDAccount：%@",json);
        block(json,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
    }];
    [operation start];
    
}




//字典转换成json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//json转换成字典
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}



@end

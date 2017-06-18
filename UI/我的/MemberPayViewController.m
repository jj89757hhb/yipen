//
//  MemberPayViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
// 会费支付

#import "MemberPayViewController.h"
#import "AppPurchase.h"
#import "RemainingPayView.h"
#import "Order.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
@interface MemberPayViewController (){
    Pay_Type pay_Type;
    Pay_Type_Weixin pay_TypeWX;//支付业务类型
    NSString *body;
}
@property(nonatomic,strong)NSString *tranNo;
@property(nonatomic,strong)NSString *totalPrice;
@end

@implementation MemberPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会费支付";
    if (self.enterType==1) {
        body=@"开通商家会员";
        pay_TypeWX=KVerify_Business;
    }
    else {
        body=@"开通个人会员";
        pay_TypeWX=KVerify_Personal;
    }
    self.payBtn.clipsToBounds=YES;
    self.payBtn.layer.cornerRadius=5;
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSString *year_Next=[dateString componentsSeparatedByString:@"."][0];
    NSString *month_Next=[dateString componentsSeparatedByString:@"."][1];
     NSString *day_Next=[dateString componentsSeparatedByString:@"."][2];
    NSLog(@"dateString:%@",dateString);
      self.dateL.text=[NSString stringWithFormat:@"%@-%d.%@.%@",dateString,[year_Next integerValue]+1,month_Next,day_Next];
    if (self.enterType==1) {
        self.memberTypeL.text=@"商家会员费";
        [self.bgIV setImage:[UIImage imageNamed:@"会员价格形状-商家"]];
        [self.costL setText:@"¥98/年"];
    }
    else{
        [self.costL setText:@"¥1/年"];
      
    }
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self.payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
      AppPurchase *app=[AppPurchase sharedAppPurchase];
    [app requestProducts];
    [SVProgressHUD show];
    [self queryPayType];
    [NotificationCenter addObserver:self selector:@selector(paySecond) name:@
     "paySecond"object:nil];
   
}

//查询将调用的支付方式
-(void)queryPayType{
    NSLog(@"BundleShortVersion:%@",BundleShortVersion);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys: [DataSource sharedDataSource].userInfo.ID,@"Uid",BundleShortVersion,@"Vcode", nil];
    
    [HttpConnection IsApplePay:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            if (![response[@"ok"] boolValue]) {//使用苹果支付
                pay_Type=KIn_app_Pay;
                [self upDatePayTypView];
            }
        }
        else{
            pay_Type=KIn_app_Pay;
            [self upDatePayTypView];
        }
        
    }];
}

-(void)upDatePayTypView{
      _payTypeL.text=@"苹果支付";
    [_selectBtn setUserInteractionEnabled:NO];
}
-(void)payAction{
    if (pay_Type==KIn_app_Pay) {
        AppPurchase *app=[AppPurchase sharedAppPurchase];
        app.memberType=pay_TypeWX;
        [app willPurchase];
    }
    else if (pay_Type==KZFB_Pay) {
            self.totalPrice=@"1";
        //                    [self alipay];
        [self aliWillPay];
    }
    else if(pay_Type==KWeiXin_Pay){
            self.totalPrice=@"1";
        [self weiXinPay];
    }
    else if(pay_Type==KYuE_Pay){
        self.totalPrice=@"1";
        RemainingPayView *view=[[RemainingPayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view initViewWithPrice:_totalPrice];
        view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
        [AppDelegateInstance.window addSubview:view];
        __weak UIView  *tempView =view;
        [view setPayBlock:^(id sender){
            NSLog(@"密码 %@",sender);
            
            [self verifyPsw:sender];
            [tempView removeFromSuperview];
        }];
        
    }

}

//余额支付 验证密码
-(void)verifyPsw:(NSString*)psw{
    [SVProgressHUD show];
    NSString *md5_Psw = [CommonFun stringTomd5:psw];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:md5_Psw,@"pwd",[DataSource sharedDataSource].userInfo.ID,@"uid",nil];
    [HttpConnection PayPwdAuthe:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
//                [self paySuccess];
                [self paySecond];
            }
            else{
                if ([response objectForKey:@"reason"]) {
                      [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:@"支付密码错误"];
                }
              
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
    }];
}



//支付第二部
-(void)paySecond{

    if (self.enterType==0) {
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",@"8",@"payType",@"1",@"payMoney",nil];
        [HttpConnection MemberPaySuccess:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
                    [DataSource sharedDataSource].userInfo.RoleType=@"1";
                    //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"已开通个人会员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];
    }
    else{
         NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",@"9",@"payType",@"1",@"payMoney",nil];
        [HttpConnection MemberPaySuccess:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
                     [DataSource sharedDataSource].userInfo.RoleType=@"2";
                    //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"已开通商家会员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                      [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];
    }
}

//支付成功 微信成功后是通知（现在只用于余额支付！！！）
-(void)paySuccess{
    [SVProgressHUD show];
    //提交数据到服务端
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID" ,_tranNo,@"tranNo",_totalPrice,@"payMoney",@"",@"ToUID",@"余额支付",@"payType",nil];
//    [HttpConnection PaySuccess:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD dismiss];
//                //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
//                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"已开通会员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            else{
//                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showInfoWithStatus:ErrorMessage];
//        }
//        
//        
//    }];
     NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",nil];
    if (self.enterType==0) {
        [HttpConnection PayPerMember:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
                    //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"已开通个人会员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];
    }
    else{
        [HttpConnection PayBusinessMember:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD dismiss];
                    //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"已开通商家会员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];
    }
    
    
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择支付
- (IBAction)selectPayAction:(id)sender {
        WS(weakSelf)
        UIActionSheet *action=[UIActionSheet bk_actionSheetWithTitle:@"支付方式"];
        [action bk_addButtonWithTitle:@"余额支付" handler:^{
            pay_Type=KYuE_Pay;
          [weakSelf setPayType];
        }];
        [action bk_addButtonWithTitle:@"支付宝支付" handler:^{
            pay_Type=KZFB_Pay;
          [weakSelf setPayType];
        }];
        [action bk_addButtonWithTitle:@"微信支付" handler:^{
            pay_Type=KWeiXin_Pay;
            [weakSelf setPayType];
            
        }];
        //    [action bk_addButtonWithTitle:@"取消" handler:^{
        //
        //    }];
        [action bk_setCancelButtonWithTitle:@"取消" handler:^{
            
        }];
        [action showInView:self.view];

}

-(void)setPayType{
    if (pay_Type==KYuE_Pay) {
        _payTypeL.text=@"余额支付";
    }
    else if (pay_Type==KZFB_Pay) {
         _payTypeL.text=@"支付宝支付";
    }
    else if (pay_Type==KWeiXin_Pay) {
         _payTypeL.text=@"微信支付";
    }
    else if (pay_Type==KIn_app_Pay) {
         _payTypeL.text=@"苹果支付";
    }
}


//微信支付
-(void)weiXinPay{
    [SVProgressHUD show];
    Pay_Type_Weixin pay_Type=KChongZhi;
    NSString *totalPrice = @"1";
    if (kDistributionTag == 2) {
        totalPrice = [NSString stringWithFormat:@"%ld",(long)[_totalPrice floatValue]*100];//传的是分为单位
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:@"-1",@"tranNo",totalPrice,@"money",@"易盘账户充值", @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",@"empty",@"Touid",[NSNumber numberWithInteger:pay_Type],@"payType",nil];
    [HttpConnection WeChatPay:dic WithBlock:^(id response, NSError *error) {
        //
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD dismiss];
                //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                NSString *appid=response[@"appid"];
                NSString *mch_id=response[@"mch_id"];
                NSString *nonce_str=response[@"nonce_str"];
                NSString *out_trade_no=response[@"out_trade_no"];
                NSString *prepay_id=response[@"prepay_id"];
                NSString *sign=response[@"sign"];
                NSString *timestamp=response[@"timestamp"];
                NSString *trade_type=response[@"trade_type"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = mch_id;
                req.prepayId            = prepay_id;
                req.nonceStr            = nonce_str;
                req.timeStamp           = [timestamp intValue];
                req.package             = trade_type;
                req.sign                = sign;
                [WXApi sendReq:req];
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
    }];
}



//支付宝预支付
-(void)aliWillPay{
    NSString *totalPrice = @"0.01";
    if (kDistributionTag == 2) {
        totalPrice = _totalPrice;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:@"-1",@"tranNo",totalPrice,@"money",body, @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",@"empty",@"Touid",[NSNumber numberWithInteger:pay_TypeWX],@"payType",nil];
    [HttpConnection AliPay:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                self.tranNo=[response objectForKey:@"tranNo"];
                NSLog(@"订单号:%@",_tranNo);
                [self alipay];
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];
    
}

-(void)alipay{
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = ZFB_partner;
    NSString *seller = ZFB_seller;
    NSString *privateKey = ZFB_privateKey;
    /*===================================================F=========================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = _tranNo; //订单ID（由商家自行制定）
    order.productName =body; //商品标题
    order.productDescription = @"empty"; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    NSString *totalPrice = @"0.01";
    if (kDistributionTag == 2) {
        totalPrice = _totalPrice;
    }
    order.amount = totalPrice;
    order.notifyURL = ZFB_CallBack_Url; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    //    NSString *appScheme = @"alisdkdemo";
    NSString *appScheme = AppScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

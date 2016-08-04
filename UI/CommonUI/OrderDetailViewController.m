//
//  OrderDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  卖家或买家订单详情

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailMySellTableViewCell.h"
#import "EditExpressInfoViewController.h"
#import "RemainingPayView.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    Pay_Type pay_Type;
    NSString *totalPrice;
}
@property(nonatomic,strong)NSString *tranNo;
@end

@implementation OrderDetailViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTable];
    [self initBottomView];
    self.title=@"订单详情";
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTable];
    if (self.enterType==1) {
        [myTable registerNib:[UINib nibWithNibName:@"OrderDetailMySellTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    }
    else{
    [myTable registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    }
    
}

-(void)initBottomView{
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor=WHITEColor;
    chatBtn=[[UIButton alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-15*2, 40)];
    [chatBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [chatBtn setTitle:@"对话" forState:UIControlStateNormal];
    [chatBtn setBackgroundColor:BLACKCOLOR];
    chatBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    chatBtn.layer.cornerRadius=5;
    chatBtn.clipsToBounds=YES;
    [bottomView addSubview:chatBtn];
    [chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
    if (self.enterType==1) {//我卖的
        if (_info.Status==KNo_Pay) {
            //        _statusL.text=@"未付款";
         
        }
        else if (_info.Status==KPay_Finish) {
            //        _statusL.text=@"已付款";
            [chatBtn setTitle:@"发货" forState:UIControlStateNormal];
            [chatBtn addTarget:self action:@selector(sendGoods:) forControlEvents:UIControlEventTouchUpInside];
              chatBtn.backgroundColor=RedColor;
        }
        else if (_info.Status==KSend_Goods) {
            //        _statusL.text=@"已发货";
        }
        else if (_info.Status==KCancel) {
            //        _statusL.text=@"已取消";
            [chatBtn setTitle:@"确认退款" forState:UIControlStateNormal];
            [chatBtn addTarget:self action:@selector(applyCancel2:) forControlEvents:UIControlEventTouchUpInside];
            chatBtn.backgroundColor=RedColor;
        }
        else if (_info.Status==KRefunded) {
            //        _statusL.text=@"已退款";
        }
        else if (_info.Status==KTakedGoods) {
            //        _statusL.text=@"已收货";
        }
    }
    else{//我买的
        if (_info.Status==KNo_Pay) {
            //        _statusL.text=@"未付款";
            [chatBtn setTitle:@"立即付款" forState:UIControlStateNormal];
            [chatBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
            chatBtn.backgroundColor=RedColor;
        }
        else if (_info.Status==KPay_Finish) {
            //        _statusL.text=@"已付款";
            [chatBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [chatBtn addTarget:self action:@selector(applyCancel:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (_info.Status==KSend_Goods) {
            //        _statusL.text=@"已发货";
        }
        else if (_info.Status==KCancel) {
            //        _statusL.text=@"已取消";
        }
        else if (_info.Status==KRefunded) {
            //        _statusL.text=@"已退款";
        }
        else if (_info.Status==KTakedGoods) {
            //        _statusL.text=@"已收货";
        }
    }
    
 
}

-(void)chatAction:(UIButton*)sender{
    
}

//发货
-(void)sendGoods:(UIButton*)sender{
    EditExpressInfoViewController *ctr=[[EditExpressInfoViewController alloc] initWithNibName:nil bundle:nil];
    ctr.tranNo=_info.TradingNo;
    [self.navigationController pushViewController:ctr animated:YES];
}

//确认退款
-(void)sureCancel:(UIButton*)sender{
    
}

//申请退款
-(void)applyCancel:(UIButton*)sender{
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"确定取消订单" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            
        }
        else{
            [SVProgressHUD show];
            Order_Status status=KCancel;
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.TradingNo,@"TradingNo",[NSNumber numberWithInteger:status],@"Status",_info.SalerID,@"ToUID", nil];
            [HttpConnection SendTrad:dic WithBlock:^(id response, NSError *error) {
                if (!error) {
                    if (!response[KErrorMsg]) {
                        [SVProgressHUD showSuccessWithStatus:@"订单已取消"];
                        
                    }
                    else{
                        [SVProgressHUD showErrorWithStatus:response[KErrorMsg]];
                    }
                }
                else{
                    [SVProgressHUD showErrorWithStatus:ErrorMessage];
                }
                
                
            }];
        }
        
    }];
 
}


//同意退款 卖方的操作
-(void)applyCancel2:(UIButton*)sender{
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"确定同意退款" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            
        }
        else{
            [SVProgressHUD show];
            Order_Status status=KRefunded;
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.TradingNo,@"TradingNo",[NSNumber numberWithInteger:status],@"Status",_info.BuyerID,@"ToUID", nil];
            [HttpConnection SendTrad:dic WithBlock:^(id response, NSError *error) {
                if (!error) {
                    if (!response[KErrorMsg]) {
                        [SVProgressHUD showSuccessWithStatus:@"已同意退款"];
                        
                    }
                    else{
                        [SVProgressHUD showErrorWithStatus:response[KErrorMsg]];
                    }
                }
                else{
                    [SVProgressHUD showErrorWithStatus:ErrorMessage];
                }
                
                
            }];
        }
        
    }];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.enterType==1) {
        return 350;
    }
    return 400;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.enterType==1) {
        OrderDetailMySellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setInfo:_info];
        return cell;
    }
    else{
        OrderDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setPay_Type:pay_Type];
        [cell setInfo:_info];
        WS(weakSelf)
        [cell setPayTypeBlock:^(id sender){
            [weakSelf selectPayType];
        }];
        return cell;
    }

}

//付款
-(void)payAction:(UIButton*)sender{
    [self payAction];
}

-(void)selectPayType{
    WS(weakSelf)
    UIActionSheet *action=[UIActionSheet bk_actionSheetWithTitle:@"支付方式"];
    [action bk_addButtonWithTitle:@"余额支付" handler:^{
        pay_Type=KYuE_Pay;
        [weakSelf reloadTable];
    }];
    [action bk_addButtonWithTitle:@"支付宝支付" handler:^{
        pay_Type=KZFB_Pay;
        [weakSelf reloadTable];
    }];
    [action bk_addButtonWithTitle:@"微信支付" handler:^{
        pay_Type=KWeiXin_Pay;
        [weakSelf reloadTable];
        
    }];
    //    [action bk_addButtonWithTitle:@"取消" handler:^{
    //
    //    }];
    [action bk_setCancelButtonWithTitle:@"取消" handler:^{
        
    }];
    [action showInView:self.view];
}

-(void)reloadTable{
    [myTable reloadData];
}

//支付
-(void)payAction{

    if ([_info.Bonsai.IsMailed boolValue]) {//卖家包邮
//        _totalPriceL.text=[NSString stringWithFormat:@"¥%@(卖家包邮)",_info.Bonsai.Price];
        totalPrice=_info.Bonsai.Price;
    }
    else{
       totalPrice=[NSString stringWithFormat:@"%.2f",[_info.Bonsai.Price floatValue]+[_info.Bonsai.MailFee floatValue]];
//        _totalPriceL.text=[NSString stringWithFormat:@"¥%@(含邮费¥%@)",totalPrice,_info.Bonsai.MailFee];
    }
    self.tranNo=_info.TradingNo;
    
                    if (pay_Type==KZFB_Pay) {
                        //                    [self alipay];
                        [self AliWilPay];
                    }
                    else if(pay_Type==KWeiXin_Pay){
                        [self weiXinPay];
                    }
                    else if(pay_Type==KYuE_Pay){
                        RemainingPayView *view=[[RemainingPayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        [view initViewWithPrice:totalPrice];
                        view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
                        [AppDelegateInstance.window addSubview:view];
                        __weak UIView  *tempView =view;
                        [view setPayBlock:^(id sender){
                            NSLog(@"密码 %@",sender);
    
                            [self verifyPsw:sender];
                            [tempView removeFromSuperview];
                        }];
                        
                    }
//    if (!_addressinfo) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"请先选择收货地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    if ([_info.Status integerValue]!=1||[_info.Num integerValue]<=0) {//Status等于1才能交易
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"库存不够啦，亲!去逛逛其他商品哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    [SVProgressHUD show];
//    //tranNo  IsMark
//    Negotiate_Type negotiate_Type=KAsk_Price_buyer;
//    Buy_Result result=KBuy;
//    NSString  *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号
//    //    if ([_info.TranNo integerValue]) {
//    //        tranNo=_info.TranNo;
//    //    }
//    WS(weakSelf)
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_info.userInfo.ID,@"toUser",_info.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",_info.IsMarksPrice,@"IsMark",tranNo,@"tranNo",_totalPrice,@"OfferPrice", nil];
//    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                self.tranNo=[response objectForKey:@"tranNo"];
//                //接着上传收货地址
//                [SVProgressHUD dismiss];
//                [weakSelf commitGoodsAddress];
//                
//                //                [SVProgressHUD showInfoWithStatus:msg];
//                
//            }
//            else{
//                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showInfoWithStatus:ErrorMessage];
//        }
//        
//    }];
//    
    
    
}

//提交收货地址
-(void)commitGoodsAddress{

//    [SVProgressHUD show];
//    WS(weakSelf)
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_tranNo,@"tranNo", address,@"address",contacter,@"contacter",mobile,@"mobile",nil];
//    [HttpConnection ShippingAddress:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD dismiss];
//                //最后一步支付
//                NSLog(@"提交收货地址ok");
//                if (pay_Type==KZFB_Pay) {
//                    //                    [self alipay];
//                    [weakSelf AliWilPay];
//                }
//                else if(pay_Type==KWeiXin_Pay){
//                    [weakSelf weiXinPay];
//                }
//                else if(pay_Type==KYuE_Pay){
//                    RemainingPayView *view=[[RemainingPayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//                    [view initViewWithPrice:_info.Price];
//                    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
//                    [AppDelegateInstance.window addSubview:view];
//                    __weak UIView  *tempView =view;
//                    [view setPayBlock:^(id sender){
//                        NSLog(@"密码 %@",sender);
//                        
//                        [weakSelf verifyPsw:sender];
//                        [tempView removeFromSuperview];
//                    }];
//                    
//                }
//            }
//            else{
//                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showInfoWithStatus:ErrorMessage];
//        }
//        
//    }];
}

//余额支付 验证密码
-(void)verifyPsw:(NSString*)psw{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:psw,@"pwd",[DataSource sharedDataSource].userInfo.ID,@"uid",nil];
    [HttpConnection PayPwdAuthe:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [self paySuccessNoti];
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

//支付成功 微信成功后是通知（现在只用于余额支付！！！）
-(void)paySuccessNoti{
    [SVProgressHUD show];
    //提交数据到服务端
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID" ,_tranNo,@"tranNo",totalPrice,@"payMoney",_info.SalerID,@"ToUID",@"余额支付",@"payType",nil];
    [HttpConnection PaySuccess:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD dismiss];
                //                [SVProgressHUD showInfoWithStatus:@"购买成功"];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"购买成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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



//支付宝支付
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
    /*============================================================================*/
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
    order.tradeNO= _tranNo;
    //    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    //    order.productName =@"test购买"; //商品标题
    //    order.productDescription = @"易盘商品"; //商品描述
    order.productName =_info.Bonsai.Title; //商品标题
    //    order.productDescription = _info.Descript ; //商品描述
    order.productDescription= _info.SalerID;//这个用于传id了！！！！！
    
    
    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  ZFB_CallBack_Url; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
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
            NSLog(@"reslut000 = %@",resultDic);
            // 9000 订单支付成功 8000 正在处理中 4000 订单支付失败 6001 用户中途取消 6002 网络连接出错
            
            if ([resultDic[@"resultStatus"] integerValue]==9000) {//支付成功
                //                   [self paySuccessNoti];
                
            }
            else if([resultDic[@"resultStatus"] integerValue]==6001){//用户取消
                [SVProgressHUD showWithStatus:@"用户中途取消"];
            }
            else if([resultDic[@"resultStatus"] integerValue]==6002){//网络出错
                [SVProgressHUD showWithStatus:@"网络连接出错"];
            }
        }];
    }
    
}

//微信支付
-(void)weiXinPay{
    Pay_Type_Weixin pay_TypeWX=KGoods_Pay;// money 1表示1分钱
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_tranNo,@"tranNo",@"1",@"money",_info.Bonsai.Title, @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",_info.SalerID,@"Touid",[NSNumber numberWithInteger:pay_TypeWX],@"payType",nil];
    [HttpConnection WeChatPay:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
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


//支付宝预支付接口
-(void)AliWilPay{
    Pay_Type_Weixin pay_TypeWX=KGoods_Pay;// money 1表示1分钱
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_tranNo,@"tranNo",@"0.01",@"money",_info.Bonsai.Title, @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",_info.SalerID,@"Touid",[NSNumber numberWithInteger:pay_TypeWX],@"payType",nil];
    [HttpConnection AliPay:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

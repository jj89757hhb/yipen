//
//  WillBuyViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "WillBuyViewController.h"
#import "WillBuyTableViewCell.h"
#import "AddressInfo.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AddressManagerViewController.h"
#import "RemainingPayView.h"
//#import "Product.h"

@interface WillBuyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    Pay_Type pay_Type;
}
@property(nonatomic,strong)AddressInfo *addressinfo;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)NSString *tranNo;//服务端返回的交易流水
@end

@implementation WillBuyViewController
static NSString *identify=@"identify";
static float Bottom_Height=50;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认购买";
    [self initTable];
    [self queryAddress];
    [self initBottomView];
    [NotificationCenter addObserver:self selector:@selector(selectAddressNoti:) name:@"SelectAddress" object:nil];
//    [NotificationCenter addObserver:self selector:@selector(paySuccessNoti) name:WeiXin_Pay_Success_Noti object:nil];
   
}

-(void)initBottomView{
    self.bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-Bottom_Height-64,SCREEN_WIDTH , Bottom_Height)];
    _bottomView.backgroundColor=WHITEColor;
    [self.view addSubview:_bottomView];
    UILabel *priceL=[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
    priceL.textColor=RedColor;
      priceL.text=[NSString stringWithFormat:@"总价 ¥%@",_totalPrice];
//    if ([_info.IsMailed boolValue]) {//包邮
//          priceL.text=[NSString stringWithFormat:@"总价 %@(包邮)",_totalPrice];
//    }
//    else{
//        float payPrice=[_totalPrice floatValue]+[_info.MailFee floatValue];
//        priceL.text=[NSString stringWithFormat:@"总价 %.2f(包含邮费:%@)",payPrice,_info.MailFee];
//    }
  
    UIButton *buyBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 80, 30)];
    buyBtn.clipsToBounds=YES;
    buyBtn.layer.cornerRadius=5;
    [buyBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [buyBtn setBackgroundColor:RedColor];
    [buyBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [_bottomView addSubview:priceL];
    [_bottomView addSubview:buyBtn];
    [buyBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
}



-(void)queryAddress{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection GetAddressList:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
//                [self.list removeAllObjects];
                NSArray *records=response[@"records"];
                for (NSDictionary *dic in records) {
                    self.addressinfo=[[AddressInfo alloc] initWithKVCDictionary:dic];
//                    [self.list addObject:info];
                    break;
                }
                
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
        
    }];
}
-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"WillBuyTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WillBuyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (_info.Attach.count) {
          [cell.treeIV sd_setImageWithURL:[NSURL URLWithString:_info.Attach[0]] placeholderImage:Default_Image];
    }
  
    [cell.titleL setText:_info.Title];
    if ([_info.IsMailed boolValue]) {//包邮
          cell.oldPriceL.text=[NSString stringWithFormat:@"¥%@(包邮)",_info.Price];
    }
    else{
        cell.oldPriceL.text=[NSString stringWithFormat:@"¥%@(邮费:¥%@)",_info.Price,_info.MailFee];
    }
    if (![_info.IsMarksPrice boolValue]) {
        cell.oldPriceL.text=@"不明价";
    }
  
    cell.nameL.text=_addressinfo.Contacter;
    cell.addressL.text=_addressinfo.Address;
    cell.phoneL.text=_addressinfo.Mobile;
    cell.saleNameL.text=self.saleUser.NickName;
    if (pay_Type==KYuE_Pay) {
        cell.payTypeL.text=@"余额支付";
    }
    else if(pay_Type==KZFB_Pay){
        cell.payTypeL.text=@"支付宝支付";
    }
    else if(pay_Type==KWeiXin_Pay){
        cell.payTypeL.text=@"微信支付";
    }
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payTypeAction)];
    [cell.bg3 addGestureRecognizer:tap];
    [cell.bg3 setUserInteractionEnabled:YES];
    [cell.selectAddressBtn addTarget:self action:@selector(selectAddressAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)payTypeAction{
//    [UIActionSheet bk_showAlertViewWithTitle:nil message:@"支付方式" cancelButtonTitle:@"取消" otherButtonTitles:@[@"余额支付",@"支付宝支付",@"微信支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        
//    }];
//    [UIActionSheet bk_actionSheetWithTitle:@"支付方式"];
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

-(void)payAction{
    if (!_addressinfo) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"请先选择收货地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([_info.Status integerValue]!=1||[_info.Num integerValue]<=0) {//Status等于1才能交易
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"库存不够啦，亲!去逛逛其他商品哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [SVProgressHUD show];
    //tranNo  IsMark
    Negotiate_Type negotiate_Type=KAsk_Price_buyer;
    Buy_Result result=KBuy;
    NSString  *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号
    NSString *toUser=nil;
    toUser=_info.userInfo.ID;
    if (_exchangeInfo) {//是助手入口购买的
        tranNo=_exchangeInfo.TranNo;
        toUser=_exchangeInfo.SalerID;
        if ([_exchangeInfo.Phase integerValue]==1) {
            negotiate_Type=KOffer_Price_Seller;
        
        }
        else if ([_exchangeInfo.Phase integerValue]==2) {
            negotiate_Type=KNegotiate_buyer;
            
        }
       else  if ([_exchangeInfo.Phase integerValue]==3) {
            negotiate_Type=KNegotiate_Seller;
            
        }
        else if ([_exchangeInfo.Phase integerValue]==4) {
            negotiate_Type=KFinal_Price;
            
        }
    }
    WS(weakSelf)
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:toUser,@"toUser",_info.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",_info.IsMarksPrice,@"IsMark",tranNo,@"tranNo",_totalPrice,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                self.tranNo=[response objectForKey:@"tranNo"];
                //接着上传收货地址
                  [SVProgressHUD dismiss];
                [weakSelf commitGoodsAddress];
              
//                [SVProgressHUD showInfoWithStatus:msg];
             
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

//提交收货地址
-(void)commitGoodsAddress{
    //address  contacter  mobile
    NSString *address=_addressinfo.Address;
    NSString *contacter=_addressinfo.Contacter;
    NSString *mobile=_addressinfo.Mobile;
    if (!address.length) {
        return;
    }
    [SVProgressHUD show];
    WS(weakSelf)
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_tranNo,@"tranNo", address,@"address",contacter,@"contacter",mobile,@"mobile",nil];
    [HttpConnection ShippingAddress:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD dismiss];
                //最后一步支付
                NSLog(@"提交收货地址ok");
                if (pay_Type==KZFB_Pay) {
                    //                    [self alipay];
                    [weakSelf AliWilPay];
                }
                else if(pay_Type==KWeiXin_Pay){
                    [weakSelf weiXinPay];
                }
                else if(pay_Type==KYuE_Pay){
                    NSString *total=_info.Price;
                    if (![_info.IsMailed boolValue]) {//不包邮
                        total=[NSString stringWithFormat:@"%.2f",[_info.MailFee floatValue]+[_info.Price floatValue]];
                    }
                    RemainingPayView *view=[[RemainingPayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [view initViewWithPrice:total];
                    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
                    [AppDelegateInstance.window addSubview:view];
                    __weak UIView  *tempView =view;
                    [view setPayBlock:^(id sender){
                        NSLog(@"密码 %@",sender);
                        
                        [weakSelf verifyPsw:sender];
                        [tempView removeFromSuperview];
                    }];
                    
                }
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

//余额支付 验证密码
-(void)verifyPsw:(NSString*)psw{
    [SVProgressHUD show];
    NSString *md5_Psw = [CommonFun stringTomd5:psw];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:md5_Psw,@"pwd",[DataSource sharedDataSource].userInfo.ID,@"uid",nil];
    [HttpConnection PayPwdAuthe:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [self paySuccessNoti];
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

//支付成功 微信成功后是通知（现在只用于余额支付！！！）
-(void)paySuccessNoti{
    [SVProgressHUD show];
    //提交数据到服务端
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID" ,_tranNo,@"tranNo",_totalPrice,@"payMoney",_saleUser.ID,@"ToUID",@"余额支付",@"payType",nil];
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

-(void)selectAddressAction{
    AddressManagerViewController *ctr=[[AddressManagerViewController alloc] init];
    ctr.enterType=1;
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)selectAddressNoti:(NSNotification*)noti{
    AddressInfo *info=noti.object;
    self.addressinfo=info;
    [myTable reloadData];
    
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
    order.productName =_info.Title; //商品标题
//    order.productDescription = _info.Descript ; //商品描述
    order.productDescription=_saleUser.ID;//这个用于传id了！！！！！

    NSString *totalPrice = @"0.01";
    if (kDistributionTag == 2) {
        totalPrice = _totalPrice;
    }
    order.amount = totalPrice;
//    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
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
                [UIAlertView bk_showAlertViewWithTitle:nil message:@"购买成功!" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    
                }];
            
            }
            else if([resultDic[@"resultStatus"] integerValue]==6001){//用户取消
                [SVProgressHUD showErrorWithStatus:@"用户中途取消"];
            }
            else if([resultDic[@"resultStatus"] integerValue]==6002){//网络出错
                [SVProgressHUD showErrorWithStatus:@"网络连接出错"];
            }
        }];
    }
    
}

//微信支付
-(void)weiXinPay{
    Pay_Type_Weixin pay_TypeWX=KGoods_Pay;// money 1表示1分钱
    NSString *totalPrice = @"1";
    if (kDistributionTag == 2) {
        totalPrice = [NSString stringWithFormat:@"%ld",(long)[_totalPrice floatValue]*100];//传的是分为单位
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_tranNo,@"tranNo",totalPrice,@"money",_info.Title, @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",_saleUser.ID,@"Touid",[NSNumber numberWithInteger:pay_TypeWX],@"payType",nil];
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
    NSString *totalPrice = @"0.01";
    if (kDistributionTag == 2) {
        totalPrice = _totalPrice;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_tranNo,@"tranNo",totalPrice,@"money",_info.Title, @"body",[DataSource sharedDataSource].userInfo.ID, @"uid",_saleUser.ID,@"Touid",[NSNumber numberWithInteger:pay_TypeWX],@"payType",nil];
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

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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

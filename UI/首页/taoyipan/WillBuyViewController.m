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
   
}

-(void)initBottomView{
    self.bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-Bottom_Height-64,SCREEN_WIDTH , Bottom_Height)];
    _bottomView.backgroundColor=WHITEColor;
    [self.view addSubview:_bottomView];
    UILabel *priceL=[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 120, 20)];
    priceL.textColor=RedColor;
    priceL.text=[NSString stringWithFormat:@"总价 %@",_totalPrice];
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
    [cell.treeIV sd_setImageWithURL:[NSURL URLWithString:_info.Attach[0]] placeholderImage:Default_Image];
    [cell.titleL setText:_info.Title];
    cell.oldPriceL.text=_info.Price;
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
    if (pay_Type==KZFB_Pay) {
         [self alipay];
    }
    else if(pay_Type==KYuE_Pay){
        RemainingPayView *view=[[RemainingPayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view initViewWithPrice:_info.Price];
        view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
        [AppDelegateInstance.window addSubview:view];
        __weak UIView  *tempView =view;
        [view setPayBlock:^(id sender){
            NSLog(@"密码 %@",sender);
            [tempView removeFromSuperview];
            
        }];
      
    }
   
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
-(void)alipay{
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088221379614269";
    NSString *seller = @"imyipen@qq.com";
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
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName =@"test购买"; //商品标题
//    order.productDescription = @"易盘商品"; //商品描述
    order.productName =_info.Title; //商品标题
    order.productDescription = _info.Descript ; //商品描述

    
    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
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

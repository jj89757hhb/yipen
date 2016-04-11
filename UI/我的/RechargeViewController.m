//
//  RechargeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "RechargeViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "Order.h"
#import "Order.h"
#import "DataSigner.h"
//#import "Product.h"
#import <AlipaySDK/AlipaySDK.h>

@interface RechargeViewController ()

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"充值";
    self.submitBtn.clipsToBounds=YES;
    self.submitBtn.layer.cornerRadius=5;
    [self.submitBtn addTarget:self action:@selector(willPayAction) forControlEvents:UIControlEventTouchUpInside];
    self.line.backgroundColor=Line_Color;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [_selectBtn addTarget:self action:@selector(selectWeixPay) forControlEvents:UIControlEventTouchUpInside];
    [_select2Btn addTarget:self action:@selector(selectZfbPay) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtn setSelected:YES];
}


-(void)willPayAction{
    if (_selectBtn.isSelected) {
        NSString *res = [WXApiRequestHandler jumpToBizPay];
        if( ![@"" isEqual:res] ){
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alter show];
        }
    }
    else{
        [self alipay];
    }
  
}


-(void)selectWeixPay{
    [_selectBtn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    [_selectBtn setSelected:YES];
    [_select2Btn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
    [_select2Btn setSelected:NO];
}

-(void)selectZfbPay{
    [_selectBtn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
    [_selectBtn setSelected:NO];
    [_select2Btn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
    [_select2Btn setSelected:YES];
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
    NSString *privateKey = @"";
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
    order.productName =@"test购买"; //商品标题
    order.productDescription = @"易盘商品"; //商品描述
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

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
